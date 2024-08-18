import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/config/constants/styles.dart';
import 'package:fooddash/app/features/order/providers/upcoming_order_provider.dart';
import 'package:fooddash/app/features/order/widgets/history_order_item.dart';
import 'package:fooddash/app/features/order/widgets/upcoming_order_item.dart';

class UpcomingOrders extends ConsumerStatefulWidget {
  const UpcomingOrders({
    super.key,
  });

  @override
  UpcomingOrdersState createState() => UpcomingOrdersState();
}

class UpcomingOrdersState extends ConsumerState<UpcomingOrders> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(upcomingOrdersProvider).orders;

    return CustomScrollView(
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

              if (order.orderStatus.id == 4) {
                return HistoryOrderItem(order: order);
              }
              return UpcomingOrderItem(order: order);
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
