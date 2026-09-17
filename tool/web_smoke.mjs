// Loads the built web app in a headless browser and fails if it does not
// render.
//
// `flutter test` runs on the Dart VM, so a failure that only happens in a
// browser passes every other gate. That is not hypothetical: a database
// opened during `main()` threw only on the web, white-screened every route,
// and reached production behind a green build.
//
// Two things are checked, because neither alone is enough:
//
//   1. Nothing throws. An exception escaping `main()` surfaces as a page
//      error or an unhandled rejection.
//   2. Something is actually painted. A white screen with no exception --
//      a layout that renders nothing, an engine that never starts -- is
//      still a broken page.
//
// The DOM cannot be used for either. Flutter attaches <flutter-view> and
// defines window.flutterCanvasKit while the *engine* boots, before main()
// runs, so a crashed app produces a DOM indistinguishable from a healthy
// one. Only the pixels tell them apart.
//
// Usage: node tool/web_smoke.mjs [buildDir]

import { createServer } from 'node:http';
import { readFile } from 'node:fs/promises';
import { join, normalize, extname } from 'node:path';
import { PNG } from 'pngjs';
import puppeteer from 'puppeteer';

const BUILD_DIR = process.argv[2] ?? 'build/web';
const ROUTES = ['/', '/submit'];

const ENGINE_TIMEOUT_MS = 45_000;
const RENDER_TIMEOUT_MS = 30_000;
const RENDER_POLL_MS = 500;

// Fraction of pixels that must differ from the page's dominant colour for it
// to count as rendered. Measured: a blank page scores 0, and the sparsest
// real screen -- one short quote on a plain background -- scores well above
// this, so the gap either side of it is wide.
const MIN_PAINTED_FRACTION = 0.004;

const MIME = {
  '.html': 'text/html',
  '.js': 'text/javascript',
  '.mjs': 'text/javascript',
  '.json': 'application/json',
  '.wasm': 'application/wasm',
  '.css': 'text/css',
  '.png': 'image/png',
  '.svg': 'image/svg+xml',
  '.ttf': 'font/ttf',
  '.otf': 'font/otf',
  '.ico': 'image/x-icon',
  '.symbols': 'text/plain',
};

/// Serves the build the way GitHub Pages does, handing unknown paths to
/// 404.html so client-side routes resolve.
function serve(dir) {
  const server = createServer(async (req, res) => {
    const path = decodeURIComponent(new URL(req.url, 'http://x').pathname);
    const file = join(dir, normalize(path).replace(/^(\.\.[/\\])+/, ''));

    const send = async (target, status) => {
      const body = await readFile(target);
      res.writeHead(status, {
        'Content-Type': MIME[extname(target)] ?? 'application/octet-stream',
        'Content-Length': body.length,
      });
      res.end(body);
    };

    try {
      await send(path.endsWith('/') ? join(file, 'index.html') : file, 200);
    } catch {
      try {
        await send(join(dir, '404.html'), 404);
      } catch {
        res.writeHead(404).end('not found');
      }
    }
  });
  return new Promise((resolve) =>
    server.listen(0, '127.0.0.1', () =>
      resolve({ server, port: server.address().port }),
    ),
  );
}

/// The share of pixels that differ from the most common colour.
function paintedFraction(pngBuffer) {
  const { data, width, height } = PNG.sync.read(pngBuffer);
  const counts = new Map();
  const total = width * height;

  for (let i = 0; i < data.length; i += 4) {
    const key = (data[i] << 16) | (data[i + 1] << 8) | data[i + 2];
    counts.set(key, (counts.get(key) ?? 0) + 1);
  }

  let dominant = 0;
  for (const count of counts.values()) dominant = Math.max(dominant, count);
  return (total - dominant) / total;
}

const { server, port } = await serve(BUILD_DIR);
const browser = await puppeteer.launch({
  args: ['--no-sandbox', '--disable-dev-shm-usage'],
});

const failures = [];

for (const route of ROUTES) {
  const page = await browser.newPage();
  await page.setViewport({ width: 1000, height: 700 });

  const errors = [];
  page.on('pageerror', (e) => errors.push(`uncaught: ${e.message.trim()}`));
  page.on('console', (m) => {
    if (m.type() !== 'error') return;
    // The SPA fallback answers unknown paths with a 404 status by design, so
    // every deep link logs a resource error.
    if (!m.text().includes('status of 404')) {
      errors.push(`console: ${m.text().trim()}`);
    }
  });
  await page.evaluateOnNewDocument(() => {
    window.__rejections = [];
    addEventListener('unhandledrejection', (e) =>
      window.__rejections.push(String(e.reason?.message ?? e.reason).trim()),
    );
  });

  let painted = 0;
  try {
    await page.goto(`http://127.0.0.1:${port}${route}`, {
      waitUntil: 'domcontentloaded',
    });

    // Engine up. This says nothing about the app yet -- it is true even when
    // main() has thrown -- but there is no point sampling pixels before it.
    await page.waitForFunction(
      () =>
        document.querySelector('flutter-view') !== null &&
        typeof window.flutterCanvasKit !== 'undefined',
      { timeout: ENGINE_TIMEOUT_MS },
    );

    // Poll until something is painted. This doubles as the settle time that
    // lets a failing main() surface its exception.
    const deadline = Date.now() + RENDER_TIMEOUT_MS;
    while (Date.now() < deadline) {
      painted = paintedFraction(await page.screenshot());
      if (painted >= MIN_PAINTED_FRACTION) break;
      await new Promise((r) => setTimeout(r, RENDER_POLL_MS));
    }

    if (painted < MIN_PAINTED_FRACTION) {
      failures.push(
        `${route}: blank page (${(painted * 100).toFixed(3)}% painted)`,
      );
      console.log(`  FAIL  ${route}  blank`);
    } else {
      console.log(`  ok    ${route}  ${(painted * 100).toFixed(1)}% painted`);
    }
  } catch (e) {
    failures.push(`${route}: ${e.message.split('\n')[0]}`);
    console.log(`  FAIL  ${route}`);
  }

  const rejections = await page
    .evaluate(() => window.__rejections ?? [])
    .catch(() => []);
  for (const r of rejections) errors.push(`unhandled rejection: ${r}`);
  for (const error of errors) failures.push(`${route}: ${error}`);

  await page.close();
}

await browser.close();
server.close();

if (failures.length > 0) {
  console.error('\nweb smoke test FAILED:');
  for (const failure of failures) console.error(`  - ${failure}`);
  process.exit(1);
}

console.log(`\nweb smoke test passed (${ROUTES.length} routes)`);
