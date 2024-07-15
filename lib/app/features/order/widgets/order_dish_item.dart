import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/features/order/models/order.dart';
import 'package:flutter/material.dart';
import 'package:fooddash/app/features/shared/utils/utils.dart';

const double heightItem = 90;

class OrderDishItem extends StatelessWidget {
  const OrderDishItem({
    super.key,
    required this.dishOrder,
  });
  final DishOrder dishOrder;

  @override
  Widget build(BuildContext context) {
    String toppingsDescription = '';
    for (var topping in dishOrder.toppingDishOrders) {
      if (toppingsDescription.isEmpty) {
        toppingsDescription = '${topping.topping.description}.';
      } else {
        toppingsDescription =
            '$toppingsDescription ${topping.topping.description}.';
      }
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${dishOrder.units}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.slate900,
              height: heightItem / 16,
              leadingDistribution: TextLeadingDistribution.even,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              dishOrder.dish.image,
              fit: BoxFit.cover,
              height: heightItem,
              width: heightItem,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 4,
                ),
                Text(
                  dishOrder.dish.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.slate900,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                if (toppingsDescription != '')
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      toppingsDescription,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.slate500,
                        height: 1.1,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      Utils.formatCurrency(
                          dishOrder.dish.price * dishOrder.units),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.slate900,
                        height: 1,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
