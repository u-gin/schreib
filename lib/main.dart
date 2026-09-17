import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';

import 'package:schreib/config/route_config.dart';

void main() {
  // Put the route in the address bar instead of hiding it behind a fragment,
  // so pages are linkable. No-op off the web.
  usePathUrlStrategy();
  runApp(MyApp(router: createAppRouter()));
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
