import 'package:delivery_app/features/auth/providers/auth_provider.dart';
import 'package:delivery_app/features/auth/screens/home_screen.dart';
import 'package:delivery_app/features/auth/screens/login_screen.dart';
import 'package:delivery_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:delivery_app/features/dish/screens/dish_screen.dart';
import 'package:delivery_app/features/order/screens/order_screen.dart';
import 'package:delivery_app/features/restaurant/screens/restaurant_screen.dart';
import 'package:delivery_app/features/shared/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_router_notifier.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _tabNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  redirect(BuildContext context, GoRouterState state) {
    final authStatus = goRouterNotifier.authStatus;
    final isGoingTo = state.fullPath;

    if (authStatus == AuthStatus.authenticated) {
      return '/dashboard';
    }

    if (authStatus == AuthStatus.notAuthenticated) {
      if (isGoingTo == '/login' || isGoingTo == '/home') return null;
      return '/home';
    }

    return null;
  }

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    refreshListenable: goRouterNotifier,
    // redirect: redirect,
    routes: [
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state, navigationShell) {
          return Tabs(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _tabNavigatorKey,
            routes: [
              GoRoute(
                path: '/dashboard',
                builder: (context, state) => const DashboardScreen(),
                parentNavigatorKey: _tabNavigatorKey,
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/order',
                builder: (context, state) => const OrderScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/favorites',
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/restaurant',
        builder: (context, state) => const RestaurantScreen(),
        parentNavigatorKey: _rootNavigatorKey,
      ),
      GoRoute(
        path: '/dish',
        builder: (context, state) => const DishScreen(),
        parentNavigatorKey: _rootNavigatorKey,
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
        parentNavigatorKey: _rootNavigatorKey,
        redirect: redirect,
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
        parentNavigatorKey: _rootNavigatorKey,
      ),
    ],
  );
});