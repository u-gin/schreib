import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:schreib/config/route_config.dart';
import 'package:schreib/data/app_database.dart';
import 'package:schreib/notifications/local_reminder_scheduler.dart';
import 'package:schreib/providers/entry_providers.dart';
import 'package:schreib/providers/reminder_providers.dart';
import 'package:schreib/repositories/local_entry_repository.dart';

void main() {
  // Put the route in the address bar instead of hiding it behind a fragment,
  // so pages are linkable. No-op off the web.
  usePathUrlStrategy();

  // Inter ships in assets/google_fonts. Refusing to fetch makes a missing
  // weight fail loudly here instead of silently becoming a network request
  // that a plane, a firewall, or a slow first paint would expose.
  GoogleFonts.config.allowRuntimeFetching = false;

  runApp(
    ProviderScope(
      // The one place the app decides where writing is stored. Phase 2 swaps
      // this for a syncing repository and nothing above it changes.
      //
      // Built on first read, never at startup. Opening a database is
      // platform-specific work that can fail -- on the web `driftDatabase`
      // throws unless it is handed wasm options -- and a failure in `main`
      // takes down the whole app, including the screens that never touch
      // storage. Web writing will need `sqlite3.wasm` and `drift_worker.js`
      // served from web/ before anything reads this.
      overrides: [
        entryRepositoryProvider.overrideWith((ref) {
          final database = AppDatabase();
          ref.onDispose(database.close);
          return LocalEntryRepository(database);
        }),
        // Also lazy, and for the same reason: the plugin loads a timezone
        // database and talks to the platform, none of which should run
        // before anything has asked for a reminder.
        reminderSchedulerProvider.overrideWith(
          (ref) => LocalReminderScheduler(),
        ),
      ],
      child: MyApp(router: createAppRouter()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Schreib',
      // Without a theme, any unstyled text falls back to Roboto, which the
      // web engine then downloads -- so bundling Inter alone does not stop
      // the app depending on the network to draw text.
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(),
      ),
      routerConfig: router,
    );
  }
}
