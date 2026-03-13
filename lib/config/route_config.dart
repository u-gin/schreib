import 'package:go_router/go_router.dart';
import 'package:schreib/screens/home_screen.dart';
import 'package:schreib/screens/submit_quote_screen.dart';

GoRouter routerConfig = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: 'submit',
      builder: (context, state) => const SubmitQuoteScreen(),
    ),
  ],
);
