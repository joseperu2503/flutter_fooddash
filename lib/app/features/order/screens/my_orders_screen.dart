import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/config/constants/styles.dart';
import 'package:fooddash/app/features/order/providers/order_provider.dart';
import 'package:fooddash/app/features/order/widgets/history_order.dart';
import 'package:fooddash/app/features/order/widgets/orders_page.dart';
import 'package:flutter/material.dart';
import 'package:fooddash/app/features/order/widgets/upcoming_order_item.dart';
import 'package:fooddash/app/features/shared/widgets/custom_switch.dart';

class MyOrdersScreen extends ConsumerStatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  MyOrdersScreenState createState() => MyOrdersScreenState();
}

class MyOrdersScreenState extends ConsumerState<MyOrdersScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    // _pageController.animateToPage(1, duration: Duration(microseconds: 0), curve: Curves.bounceOut);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: horizontalPaddingMobile,
                right: horizontalPaddingMobile,
                top: 24,
                bottom: 8,
              ),
              child: CustomSwitch(
                pageController: _pageController,
                label1: 'Upcoming',
                label2: 'History',
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {});
                },
                children: [
                  OrdersPage(
                    orderProvider: upcomingOrdersProvider,
                    orderWidget: (order) => UpcomingOrderItem(order: order),
                  ),
                  OrdersPage(
                    orderProvider: historyOrdersProvider,
                    orderWidget: (order) => HistoryOrderItem(order: order),
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
