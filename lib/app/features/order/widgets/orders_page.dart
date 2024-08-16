import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/config/constants/styles.dart';
import 'package:fooddash/app/features/order/models/order.dart';
import 'package:fooddash/app/features/order/providers/order_provider.dart';

class OrdersPage extends ConsumerStatefulWidget {
  const OrdersPage({
    super.key,
    required this.orderProvider,
    required this.orderWidget,
  });

  final Widget Function(Order order) orderWidget;

  @override
  OrdersPageState createState() => OrdersPageState();

  final StateNotifierProvider<OrderNotifier, OrderState> orderProvider;
}

class OrdersPageState extends ConsumerState<OrdersPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(widget.orderProvider.notifier).initData();
      ref.read(widget.orderProvider.notifier).getMyOrders();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels + 100 >=
          _scrollController.position.maxScrollExtent) {
        ref.read(widget.orderProvider.notifier).getMyOrders();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(widget.orderProvider).orders;

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(
            left: horizontalPaddingMobile,
            right: horizontalPaddingMobile,
            top: 24,
            bottom: 24,
          ),
          sliver: SliverList.separated(
            itemBuilder: (context, index) {
              final order = orders[index];
              return widget.orderWidget(order);
            },
            separatorBuilder: (context, index) {
              return Container(
                height: 20,
              );
            },
            itemCount: orders.length,
          ),
        ),
      ],
    );
  }
}
