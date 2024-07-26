import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/config/router/app_router.dart';
import 'package:fooddash/app/features/cart/providers/cart_provider.dart';
import 'package:fooddash/app/features/checkout/widgets/order_successfully.dart';
import 'package:fooddash/app/features/core/models/service_exception.dart';
import 'package:fooddash/app/features/order/models/order.dart';
import 'package:fooddash/app/features/order/models/order_request.dart';
import 'package:fooddash/app/features/order/services/order_service.dart';
import 'package:fooddash/app/features/shared/models/loading_status.dart';
import 'package:fooddash/app/features/shared/services/snackbar_service.dart';

final orderProvider = StateNotifierProvider<OrderNotifier, OrderState>((ref) {
  return OrderNotifier(ref);
});

class OrderNotifier extends StateNotifier<OrderState> {
  OrderNotifier(this.ref) : super(OrderState());
  final StateNotifierProviderRef ref;

  initData() {
    state = state.copyWith(
      orders: [],
      loadingOrders: LoadingStatus.none,
    );
  }

  Future<void> getMyOrders() async {
    if (state.loadingOrders == LoadingStatus.loading) return;

    state = state.copyWith(
      loadingOrders: LoadingStatus.loading,
    );

    try {
      final List<Order> response = await OrderService.getMyOrders();
      state = state.copyWith(
        orders: response,
        loadingOrders: LoadingStatus.success,
      );
    } on ServiceException catch (e) {
      SnackBarService.show(e.message);

      state = state.copyWith(
        orders: [],
        loadingOrders: LoadingStatus.error,
      );
    }
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
      await OrderService.createOrder(orderRequest);
      await ref.read(cartProvider.notifier).getMyCart();
      await ref.read(orderProvider.notifier).getMyOrders();

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
          return const OrderSuccessfully();
        },
      );
    } on ServiceException catch (e) {
      SnackBarService.show(e.message);

      state = state.copyWith(
        creatingOrder: LoadingStatus.error,
      );
    }
  }

  void setOrder(Order order) {
    state = state.copyWith(
      order: () => order,
      loadingOrder: LoadingStatus.success,
    );
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
      return;
    }

    try {
      final Order response = await OrderService.getOrder(orderId: orderId);
      state = state.copyWith(
        order: () => response,
        loadingOrder: LoadingStatus.success,
      );
    } on ServiceException catch (e) {
      SnackBarService.show(e.message);

      state = state.copyWith(
        order: () => null,
        loadingOrder: LoadingStatus.error,
      );
    }
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
