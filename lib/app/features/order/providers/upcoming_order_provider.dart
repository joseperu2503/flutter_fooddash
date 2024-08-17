import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/config/router/app_router.dart';
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
  final StateNotifierProviderRef ref;

  resetOrders() {
    state = state.copyWith(
      orders: [],
      page: 1,
      totalPages: 1,
      loadingOrders: LoadingStatus.none,
    );
    getOrders();
  }

  Future<void> getOrders() async {
    print('getOrders upcoming');

    if (state.page > state.totalPages ||
        state.loadingOrders == LoadingStatus.loading) return;

    state = state.copyWith(
      loadingOrders: LoadingStatus.loading,
    );

    try {
      final OrdersResponse response = await OrderService.getMyOrders(
        orderStatuses: [1, 2, 3],
      );
      state = state.copyWith(
        orders: response.items,
        totalPages: response.meta.totalPages,
        page: state.page + 1,
        loadingOrders: LoadingStatus.success,
      );

      for (var order in state.orders) {
        disconnectSocket(order.id);

        final orderSocketService = OrderSocket(
          orderId: order.id,
          orderUpdate: (updatedOrder) {
            state = state.copyWith(
              orders: state.orders.map((o) {
                if (updatedOrder.id == o.id) {
                  return updatedOrder;
                }
                return o;
              }).toList(),
            );
            if (updatedOrder.orderStatus.id == 4) {
              disconnectSocket(order.id);

              resetOrders();

              ref.read(historyOrdersProvider.notifier).initData();
              ref.read(historyOrdersProvider.notifier).getOrders();
            }
          },
        );

        await orderSocketService.connect();

        _activeSockets[order.id] = orderSocketService;
      }
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
      await resetOrders();

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

  void goTrackOrder(Order order) {
    state = state.copyWith(
      order: () => order,
    );
    appRouter.push('/track-order/${order.id}');
  }

  final Map<int, OrderSocket> _activeSockets = {};

  Future<void> getOrder(int orderId) async {
    state = state.copyWith(
      loadingOrder: LoadingStatus.loading,
    );

    if (state.order == null) {
      final orderIndex =
          state.orders.indexWhere((order) => order.id == orderId);

      if (orderIndex >= 0) {
        setOrder(state.orders[orderIndex]);
      }
    }

    disconnectSocket(orderId);

    final orderSocketService = OrderSocket(
      orderId: orderId,
      orderUpdate: (order) {
        setOrder(order);
      },
    );

    await orderSocketService.connect();

    _activeSockets[orderId] = orderSocketService;
  }

  setOrder(Order order) {
    state = state.copyWith(
      order: () => order,
      loadingOrder: LoadingStatus.success,
    );

    if (order.orderStatus.id == 4) {
      disconnectSocket(order.id);
      ref.read(historyOrdersProvider.notifier).getOrders();
    }
  }

  disconnectSocket(int orderId) {
    if (_activeSockets[orderId] != null) {
      _activeSockets[orderId]!.disconnect();
    }
  }
}

class OrderState {
  final List<Order> orders;
  final int page;
  final int totalPages;
  final LoadingStatus loadingOrders;
  final Order? order;
  final LoadingStatus loadingOrder;
  final LoadingStatus creatingOrder;

  OrderState({
    this.orders = const [],
    this.page = 1,
    this.totalPages = 1,
    this.loadingOrders = LoadingStatus.none,
    this.order,
    this.loadingOrder = LoadingStatus.none,
    this.creatingOrder = LoadingStatus.none,
  });

  OrderState copyWith({
    List<Order>? orders,
    int? page,
    int? totalPages,
    LoadingStatus? loadingOrders,
    ValueGetter<Order?>? order,
    LoadingStatus? loadingOrder,
    LoadingStatus? creatingOrder,
  }) =>
      OrderState(
        orders: orders ?? this.orders,
        page: page ?? this.page,
        totalPages: totalPages ?? this.totalPages,
        loadingOrders: loadingOrders ?? this.loadingOrders,
        order: order != null ? order() : this.order,
        loadingOrder: loadingOrder ?? this.loadingOrder,
        creatingOrder: creatingOrder ?? this.creatingOrder,
      );
}
