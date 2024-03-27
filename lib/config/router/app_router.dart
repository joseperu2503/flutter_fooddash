import 'package:delivery_app/features/auth/providers/auth_provider.dart';
import 'package:delivery_app/features/auth/screens/home_screen.dart';
import 'package:delivery_app/features/auth/screens/login_screen.dart';
import 'package:delivery_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_router_notifier.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/home',
    refreshListenable: goRouterNotifier,
    redirect: (context, state) {
      final authStatus = goRouterNotifier.authStatus;

      if (authStatus == AuthStatus.authenticated) {
        return '/dashboard';
      } else {
        return '/home';
      }
    },
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
    ],
  );
});
