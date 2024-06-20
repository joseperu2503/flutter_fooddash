import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/config/constants/app_colors.dart';
import 'package:fooddash/features/cart/models/cart_response.dart';
import 'package:flutter/material.dart';
import 'package:fooddash/features/cart/providers/cart_provider.dart';
import 'package:fooddash/features/shared/utils/utils.dart';
import 'package:fooddash/features/shared/widgets/button_stepper_2.dart';

const double heightItem = 90;

class CartDishItem extends ConsumerWidget {
  const CartDishItem({
    super.key,
    required this.dishCart,
    required this.index,
  });
  final DishCart dishCart;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String toppingsDescription = '';
    for (var topping in dishCart.toppingDishCarts) {
      if (toppingsDescription.isEmpty) {
        toppingsDescription = '${topping.description}.';
      } else {
        toppingsDescription = '$toppingsDescription ${topping.description}.';
      }
    }

    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              dishCart.image,
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
                  dishCart.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColors.slate900,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                if (toppingsDescription != '')
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      toppingsDescription,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.slate500,
                        height: 1.2,
                        leadingDistribution: TextLeadingDistribution.even,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      Utils.formatCurrency(dishCart.price * dishCart.units),
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
                Row(
                  children: [
                    const Spacer(),
                    ButtonStepper2(
                      value: dishCart.units,
                      onAdd: () {
                        ref.read(cartProvider.notifier).addUnitDish(index);
                      },
                      onRemove: () {
                        ref.read(cartProvider.notifier).removeUnitDish(index);
                      },
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
