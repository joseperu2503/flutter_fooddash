import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/config/router/app_router.dart';
import 'package:fooddash/app/features/auth/services/auth_service.dart';
import 'package:fooddash/app/features/cart/providers/cart_provider.dart';
import 'package:fooddash/app/features/checkout/widgets/order_successfully.dart';
import 'package:fooddash/app/features/core/models/service_exception.dart';
import 'package:fooddash/app/features/order/models/order.dart';
import 'package:fooddash/app/features/order/models/order_request.dart';
import 'package:fooddash/app/features/order/providers/history_order_provider.dart';
import 'package:fooddash/app/features/order/services/order_service.dart';
import 'package:fooddash/app/features/order/services/order_socket.dart';
import 'package:fooddash/app/features/shared/models/loading_status.dart';
import 'package:fooddash/app/features/shared/services/snackbar_service.dart';

final upcomingOrdersProvider =
    StateNotifierProvider<UpcomingOrdersNotifier, OrderState>((ref) {
  return UpcomingOrdersNotifier(ref);
});

class UpcomingOrdersNotifier extends StateNotifier<OrderState> {
  UpcomingOrdersNotifier(this.ref) : super(OrderState());
  final Ref ref;

  OrderSocket? socket;

  connectSocket() async {
    disconnectSocket();
    final (validToken, _) = await AuthService.verifyToken();

    state = state.copyWith(
      orders: [],
      order: () => null,
    );

    if (!validToken) return;
    socket = OrderSocket(
      upcomingOrdersUpdated: (updatedOrders) {
        if (updatedOrders.length < state.orders.length) {
          ref.read(historyOrdersProvider.notifier).getOrders();
        }

        state = state.copyWith(
          orders: updatedOrders,
        );
      },
    );

    await socket?.connect();
  }

  Future<void> createOrder() async {
    if (state.creatingOrder == LoadingStatus.loading) return;
    final cartState = ref.read(cartProvider);
    if (cartState.cartResponse == null) return;

    state = state.copyWith(
      creatingOrder: LoadingStatus.loading,
    );

    final orderRequest = OrderRequest(
      restaurantId: cartState.cartResponse!.restaurant.id,
      dishes: cartState.dishesForOrderRequest,
      addressId: cartState.cartResponse!.address.id,
      paymentMethodId: 'cash',
    );

    try {
      final Order order = await OrderService.createOrder(orderRequest);
      await ref.read(cartProvider.notifier).getMyCart();

      state = state.copyWith(
        creatingOrder: LoadingStatus.success,
      );
      if (rootNavigatorKey.currentContext == null) return;

      showModalBottomSheet(
        context: rootNavigatorKey.currentContext!,
        elevation: 0,
        isDismissible: false,
        enableDrag: false,
        builder: (context) {
          return OrderSuccessfully(orderId: order.id);
        },
      );
    } on ServiceException catch (e) {
      SnackBarService.show(e.message);

      state = state.copyWith(
        creatingOrder: LoadingStatus.error,
      );
    }
  }

  void goTrackOrder(Order order) {
    state = state.copyWith(
      order: () => order,
    );
    appRouter.push('/my-orders/track-order/${order.id}');
  }

  Future<void> getOrder(int orderId) async {
    state = state.copyWith(
      loadingOrder: LoadingStatus.loading,
    );

    final orderIndex = state.orders.indexWhere((order) => order.id == orderId);

    if (orderIndex >= 0) {
      state = state.copyWith(
        order: () => state.orders[orderIndex],
        loadingOrder: LoadingStatus.success,
      );
    }
  }

  disconnectSocket() {
    socket?.disconnect();
  }
}

class OrderState {
  final List<Order> orders;
  final LoadingStatus loadingOrders;
  final Order? order;
  final LoadingStatus loadingOrder;
  final LoadingStatus creatingOrder;

  OrderState({
    this.orders = const [],
    this.loadingOrders = LoadingStatus.none,
    this.order,
    this.loadingOrder = LoadingStatus.none,
    this.creatingOrder = LoadingStatus.none,
  });

  OrderState copyWith({
    List<Order>? orders,
    LoadingStatus? loadingOrders,
    ValueGetter<Order?>? order,
    LoadingStatus? loadingOrder,
    LoadingStatus? creatingOrder,
  }) =>
      OrderState(
        orders: orders ?? this.orders,
        loadingOrders: loadingOrders ?? this.loadingOrders,
        order: order != null ? order() : this.order,
        loadingOrder: loadingOrder ?? this.loadingOrder,
        creatingOrder: creatingOrder ?? this.creatingOrder,
      );
}
