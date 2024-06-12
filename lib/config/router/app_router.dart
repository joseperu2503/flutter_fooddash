import 'package:delivery_app/features/address/screens/address_map_screen.dart';
import 'package:delivery_app/features/address/screens/confirm_address_screen.dart';
import 'package:delivery_app/features/address/screens/search_address_screen.dart';
import 'package:delivery_app/features/auth/providers/auth_provider.dart';
import 'package:delivery_app/features/auth/screens/home_screen.dart';
import 'package:delivery_app/features/auth/screens/login_screen.dart';
import 'package:delivery_app/features/cart/screens/cart_screen.dart';
import 'package:delivery_app/features/checkout/screens/checkout_screen.dart';
import 'package:delivery_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:delivery_app/features/dish/screens/dish_screen.dart';
import 'package:delivery_app/features/favorites/screens/favorites_screen.dart';
import 'package:delivery_app/features/notifications/screens/notifications_screen.dart';
import 'package:delivery_app/features/order/screens/my_orders_screen.dart';
import 'package:delivery_app/features/order/screens/order_screen.dart';
import 'package:delivery_app/features/payment_methods/screens/card_form_screen.dart';
import 'package:delivery_app/features/payment_methods/screens/payment_methods_screen.dart';
import 'package:delivery_app/features/profile/screens/profile_screen.dart';
import 'package:delivery_app/features/restaurant/screens/restaurant_screen.dart';
import 'package:delivery_app/features/shared/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'app_router_notifier.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _tabNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<TabsState> tabKey = GlobalKey<TabsState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  unprotectedRoute(BuildContext context, GoRouterState state) {
    final authStatus = goRouterNotifier.authStatus;

    if (authStatus == AuthStatus.authenticated) {
      return '/dashboard';
    }

    return null;
  }

  protectedRoute(BuildContext context, GoRouterState state) {
    final authStatus = goRouterNotifier.authStatus;

    if (authStatus == AuthStatus.notAuthenticated) {
      return '/';
    }

    return null;
  }

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    refreshListenable: goRouterNotifier,
    routes: [
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state, navigationShell) {
          return Tabs(
            key: tabKey,
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
                redirect: protectedRoute,
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/my-orders',
                builder: (context, state) => const MyOrdersScreen(),
                redirect: protectedRoute,
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/favorites',
                builder: (context, state) => const FavoriteScreen(),
                redirect: protectedRoute,
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/notifications',
                builder: (context, state) => const NotificationsScreen(),
                redirect: protectedRoute,
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/restaurant/:restaurantId',
        builder: (context, state) => RestaurantScreen(
          restaurantId: state.pathParameters['restaurantId'] ?? '',
        ),
        parentNavigatorKey: rootNavigatorKey,
        redirect: protectedRoute,
      ),
      GoRoute(
        path: '/dish/:dishId',
        builder: (context, state) => DishScreen(
          dishId: state.pathParameters['dishId'] ?? '',
        ),
        redirect: protectedRoute,
        parentNavigatorKey: rootNavigatorKey,
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartScreen(),
        redirect: protectedRoute,
        parentNavigatorKey: rootNavigatorKey,
      ),
      GoRoute(
        path: '/checkout',
        builder: (context, state) => const CheckoutScreen(),
        redirect: protectedRoute,
        parentNavigatorKey: rootNavigatorKey,
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
        parentNavigatorKey: rootNavigatorKey,
        redirect: unprotectedRoute,
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
        parentNavigatorKey: rootNavigatorKey,
        redirect: unprotectedRoute,
      ),
      GoRoute(
        path: '/order',
        builder: (context, state) => const OrderScreen(),
        redirect: protectedRoute,
        parentNavigatorKey: rootNavigatorKey,
      ),
      GoRoute(
        path: '/search-address',
        builder: (context, state) => const SearchAddressScreen(),
        redirect: protectedRoute,
        parentNavigatorKey: rootNavigatorKey,
      ),
      GoRoute(
        path: '/address-map',
        builder: (context, state) => const AddressMapScreen(),
        redirect: protectedRoute,
        parentNavigatorKey: rootNavigatorKey,
      ),
      GoRoute(
        path: '/confirm-address',
        builder: (context, state) => const ConfirmAddressScreen(),
        redirect: protectedRoute,
        parentNavigatorKey: rootNavigatorKey,
      ),
      GoRoute(
        path: '/card-form',
        builder: (context, state) => const CardFormScreen(),
        redirect: protectedRoute,
        parentNavigatorKey: rootNavigatorKey,
      ),
      GoRoute(
        path: '/payment-methods',
        builder: (context, state) => const PaymentMethodsScreen(),
        redirect: protectedRoute,
        parentNavigatorKey: rootNavigatorKey,
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
        redirect: protectedRoute,
        parentNavigatorKey: rootNavigatorKey,
      ),
    ],
  );
});
