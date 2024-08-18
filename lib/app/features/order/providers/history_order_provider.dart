import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/config/router/app_router.dart';
import 'package:fooddash/app/features/core/models/service_exception.dart';
import 'package:fooddash/app/features/order/models/order.dart';
import 'package:fooddash/app/features/order/services/order_service.dart';
import 'package:fooddash/app/features/shared/models/loading_status.dart';
import 'package:fooddash/app/features/shared/services/snackbar_service.dart';

final historyOrdersProvider =
    StateNotifierProvider<HistoryOrdersNotifier, OrderState>((ref) {
  return HistoryOrdersNotifier(ref);
});

class HistoryOrdersNotifier extends StateNotifier<OrderState> {
  HistoryOrdersNotifier(this.ref) : super(OrderState());
  final StateNotifierProviderRef ref;

  resetData() {
    print('initData history');

    state = state.copyWith(
      orders: [],
      page: 1,
      totalPages: 1,
      loadingOrders: LoadingStatus.none,
    );

    getOrders();
  }

  Future<void> getOrders() async {
    print('get orders history');
    print(state.page);
    print(state.totalPages);

    if (state.page > state.totalPages ||
        state.loadingOrders == LoadingStatus.loading) return;

    state = state.copyWith(
      loadingOrders: LoadingStatus.loading,
    );

    try {
      final OrdersResponse response = await OrderService.getMyOrders(
        page: state.page,
        orderStatuses: [4],
      );
      state = state.copyWith(
        orders: [...state.orders, ...response.items],
        totalPages: response.meta.totalPages,
        page: state.page + 1,
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

  void goToOrder(Order order) {
    state = state.copyWith(
      order: () => order,
    );
    appRouter.push('/order/${order.id}');
  }

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
  }

  setOrder(Order order) {
    state = state.copyWith(
      order: () => order,
      loadingOrder: LoadingStatus.success,
    );
  }
}

class OrderState {
  final List<Order> orders;
  final int page;
  final int totalPages;
  final LoadingStatus loadingOrders;
  final Order? order;
  final LoadingStatus loadingOrder;

  OrderState({
    this.orders = const [],
    this.page = 1,
    this.totalPages = 1,
    this.loadingOrders = LoadingStatus.none,
    this.order,
    this.loadingOrder = LoadingStatus.none,
  });

  OrderState copyWith({
    List<Order>? orders,
    int? page,
    int? totalPages,
    LoadingStatus? loadingOrders,
    ValueGetter<Order?>? order,
    LoadingStatus? loadingOrder,
  }) =>
      OrderState(
        orders: orders ?? this.orders,
        page: page ?? this.page,
        totalPages: totalPages ?? this.totalPages,
        loadingOrders: loadingOrders ?? this.loadingOrders,
        order: order != null ? order() : this.order,
        loadingOrder: loadingOrder ?? this.loadingOrder,
      );
}
