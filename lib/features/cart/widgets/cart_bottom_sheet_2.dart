import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/config/constants/app_colors.dart';
import 'package:fooddash/features/cart/providers/cart_provider.dart';
import 'package:fooddash/features/shared/models/loading_status.dart';
import 'package:fooddash/features/shared/utils/utils.dart';
import 'package:fooddash/features/shared/widgets/custom_button.dart';
import 'package:go_router/go_router.dart';

class CartBottomSheet2 extends ConsumerWidget {
  const CartBottomSheet2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);

    return Container(
      height: 120,
      padding: const EdgeInsets.only(
        top: 16,
        left: 24,
        right: 24,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(42),
          topRight: Radius.circular(42),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(63, 76, 95, 0.12),
            offset: Offset(0, -4),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartState.numDishes! > 1
                          ? '${cartState.numDishes} products'
                          : '${cartState.numDishes} product',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.slate500,
                        height: 1.5,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                    Text(
                      Utils.formatCurrency(cartState.cartResponse?.subtotal),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.slate800,
                        height: 1.5,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 24,
                ),
                const Spacer(),
                CustomButton(
                  width: 200,
                  onPressed: () {
                    context.push('/cart');
                  },
                  loading: cartState.loading == LoadingStatus.loading,
                  disabled: cartState.cartResponse == null,
                  text: 'Go to cart',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
