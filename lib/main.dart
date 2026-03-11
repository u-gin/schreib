import 'package:flutter/material.dart';
import 'package:schreib/config/route_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Schreib',
      routerConfig: routerConfig,
    );
  }
}
