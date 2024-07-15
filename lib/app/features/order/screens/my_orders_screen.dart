import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/features/order/providers/order_provider.dart';
import 'package:fooddash/app/features/order/widgets/order_switch.dart';
import 'package:fooddash/app/features/order/widgets/upcoming_order_item.dart';
import 'package:flutter/material.dart';

class MyOrdersScreen extends ConsumerStatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  MyOrdersScreenState createState() => MyOrdersScreenState();
}

class MyOrdersScreenState extends ConsumerState<MyOrdersScreen> {
  OrderType orderType = OrderType.upcoming;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orderProvider.notifier).initData();
      ref.read(orderProvider.notifier).getMyOrders();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          flexibleSpace: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            height: 60,
            child: const Row(
              children: [
                Spacer(),
                Text(
                  'My Orders',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColors.input,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom: 8,
              ),
              child: OrderSwitch(
                orderType: orderType,
                onChange: (value) {
                  setState(() {
                    orderType = value;
                  });
                },
                width: MediaQuery.of(context).size.width - 2 * 24,
              ),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 24,
                      bottom: 30,
                    ),
                    sliver: SliverList.separated(
                      itemBuilder: (context, index) {
                        final order = orderState.orders[index];
                        return UpcomingOrderItem(
                          order: order,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          height: 20,
                        );
                      },
                      itemCount: orderState.orders.length,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum OrderType { upcoming, history }
