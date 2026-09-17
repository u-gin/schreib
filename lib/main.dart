import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';

import 'package:schreib/config/route_config.dart';
import 'package:schreib/data/app_database.dart';
import 'package:schreib/providers/entry_providers.dart';
import 'package:schreib/repositories/local_entry_repository.dart';

void main() {
  // Put the route in the address bar instead of hiding it behind a fragment,
  // so pages are linkable. No-op off the web.
  usePathUrlStrategy();

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
      routerConfig: router,
    );
  }
}
