import 'package:fooddash/app/features/address/screens/address_map_screen.dart';
import 'package:fooddash/app/features/address/screens/confirm_address_screen.dart';
import 'package:fooddash/app/features/address/screens/my_addresses_screen.dart';
import 'package:fooddash/app/features/address/screens/search_address_screen.dart';
import 'package:fooddash/app/features/auth/screens/home_screen.dart';
import 'package:fooddash/app/features/auth/screens/login_screen.dart';
import 'package:fooddash/app/features/auth/services/auth_service.dart';
import 'package:fooddash/app/features/cart/screens/cart_screen.dart';
import 'package:fooddash/app/features/checkout/screens/checkout_screen.dart';
import 'package:fooddash/app/features/dashboard/screens/dashboard_screen.dart';
import 'package:fooddash/app/features/dish/screens/dish_screen.dart';
import 'package:fooddash/app/features/favorites/screens/favorites_screen.dart';
import 'package:fooddash/app/features/menu/screens/menu_screen.dart';
import 'package:fooddash/app/features/order/screens/my_orders_screen.dart';
import 'package:fooddash/app/features/order/screens/order_screen.dart';
import 'package:fooddash/app/features/order/screens/track_order_screen.dart';
import 'package:fooddash/app/features/payment_methods/screens/card_detail_screen.dart';
import 'package:fooddash/app/features/payment_methods/screens/card_form_screen.dart';
import 'package:fooddash/app/features/payment_methods/screens/payment_methods_screen.dart';
import 'package:fooddash/app/features/profile/screens/profile_screen.dart';
import 'package:fooddash/app/features/restaurant/screens/restaurant_screen.dart';
import 'package:fooddash/app/features/shared/widgets/internal_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

Future<String?> unprotectedRoute(
    BuildContext context, GoRouterState state) async {
  final (validToken, _) = await AuthService.verifyToken();

  if (validToken) {
    return '/dashboard';
  }

  return null;
}

Future<String?> protectedRoute(
    BuildContext context, GoRouterState state) async {
  final (validToken, _) = await AuthService.verifyToken();

  if (!validToken) {
    return '/';
  }

  return null;
}

GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state, navigationShell) {
        return InternalLayout(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => const DashboardScreen(),
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
              routes: [
                GoRoute(
                  path: 'track-order/:orderId',
                  builder: (context, state) => TrackOrderScreen(
                    orderId:
                        int.tryParse(state.pathParameters['orderId'] ?? '0') ??
                            0,
                  ),
                  redirect: protectedRoute,
                  parentNavigatorKey: rootNavigatorKey,
                ),
              ],
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
              path: '/menu',
              builder: (context, state) => const MenuScreen(),
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
      path: '/track-order/:orderId',
      builder: (context, state) => TrackOrderScreen(
        orderId: int.tryParse(state.pathParameters['orderId'] ?? '0') ?? 0,
      ),
      redirect: protectedRoute,
      parentNavigatorKey: rootNavigatorKey,
    ),
    GoRoute(
      path: '/order/:orderId',
      builder: (context, state) => OrderScreen(
        orderId: int.tryParse(state.pathParameters['orderId'] ?? '0') ?? 0,
      ),
      redirect: protectedRoute,
      parentNavigatorKey: rootNavigatorKey,
    ),
    GoRoute(
      path: '/my-addresses',
      builder: (context, state) => const MyAddressesScreen(),
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
      routes: [
        GoRoute(
          path: 'card-detail/:cardId',
          builder: (context, state) => CardDetailScreen(
            cardId: state.pathParameters['cardId'] ?? '',
          ),
          redirect: protectedRoute,
          parentNavigatorKey: rootNavigatorKey,
        ),
      ],
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
      redirect: protectedRoute,
      parentNavigatorKey: rootNavigatorKey,
    ),
  ],
);
