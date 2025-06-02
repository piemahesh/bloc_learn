import 'package:bloc_learn/blocs/block.dart';
import 'package:bloc_learn/screens/screen.dart';
import 'package:bloc_learn/utils/utils.dart';
import 'package:go_router/go_router.dart';

// final appRouter = GoRouter(
//   initialLocation: '/',
//   routes: <RouteBase>[
//     GoRoute(
//       path: '/',
//       name: "login",
//       builder: (context, state) => const LoginScreen(),
//     ),
//     GoRoute(
//       path: '/home',
//       name: 'home',
//       builder: (context, state) => const HomeScreen(),
//     ),
//   ],
// );
class AppRouter {
  final AuthBloc authBloc;

  AppRouter({required this.authBloc});

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefreshBloc(authBloc),
    redirect: (context, state) {
      final authState = authBloc.state;
      final isLoggingIn = state.matchedLocation == '/';
      if (authState is Unauthenticated && !isLoggingIn) return '/';
      if (authState is Authenticated && isLoggingIn) return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    ],
  );
}
