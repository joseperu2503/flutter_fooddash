import 'package:flutter/material.dart';
import 'package:fooddash/config/constants/styles.dart';
import 'package:fooddash/features/order/models/order.dart';
import 'package:fooddash/features/order/widgets/order_dish_item.dart';
import 'package:fooddash/features/shared/widgets/back_button.dart';

class DishesScreen extends StatelessWidget {
  const DishesScreen({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            height: 60,
            child: const Row(
              children: [
                CustomBackButton(),
                Spacer(),
                Text(
                  'Food List',
                  style: appBarTitle,
                ),
                Spacer(),
                SizedBox(
                  width: 38,
                  height: 38,
                ),
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(
              top: 40,
              left: 24,
              right: 24,
              bottom: MediaQuery.of(context).padding.bottom + 30,
            ),
            sliver: SliverList.separated(
              itemBuilder: (context, index) {
                final dish = order.dishOrders[index];

                return OrderDishItem(dishOrder: dish);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 32,
                );
              },
              itemCount: order.dishOrders.length,
            ),
          ),
        ],
      ),
    );
  }
}
