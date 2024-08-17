import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/config/constants/styles.dart';
import 'package:fooddash/app/features/order/providers/history_order_provider.dart';
import 'package:fooddash/app/features/order/widgets/history_order_item.dart';

class HistoryOrders extends ConsumerStatefulWidget {
  const HistoryOrders({
    super.key,
  });

  @override
  OrdersPageState createState() => OrdersPageState();
}

class OrdersPageState extends ConsumerState<HistoryOrders> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    print('initState upcoming');

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(historyOrdersProvider.notifier).initData();
      ref.read(historyOrdersProvider.notifier).getOrders();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels + 100 >=
          _scrollController.position.maxScrollExtent) {
        ref.read(historyOrdersProvider.notifier).getOrders();
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
    final orders = ref.watch(historyOrdersProvider).orders;

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
              return HistoryOrderItem(order: order);
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
