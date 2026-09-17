import 'package:go_router/go_router.dart';
import 'package:schreib/screens/home_screen.dart';
import 'package:schreib/screens/submit_quote_screen.dart';

/// Builds a fresh router. A single shared instance carries its navigation
/// history with it, which leaks between widget tests, so callers own theirs.
GoRouter createAppRouter({String initialLocation = '/'}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/submit',
        builder: (context, state) => const SubmitQuoteScreen(),
      ),
    ],
  );
}
