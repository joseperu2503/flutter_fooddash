import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/features/cart/providers/cart_provider.dart';
import 'package:go_router/go_router.dart';

class CartButton extends ConsumerWidget {
  const CartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);

    return Container(
      width: 60,
      height: 42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: (cartState.numDishes != null && cartState.numDishes! > 0)
            ? [
                BoxShadow(
                  color: AppColors.orange.withOpacity(0.3),
                  offset: const Offset(0, 4),
                  blurRadius: 15,
                  spreadRadius: 0,
                )
              ]
            : null,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor:
              (cartState.numDishes != null && cartState.numDishes! > 0)
                  ? AppColors.primary
                  : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(
              30,
            ),
          ),
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          if (cartState.numDishes == null) return;
          context.push('/cart');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/cart_outlined.svg',
              width: 24,
              colorFilter: ColorFilter.mode(
                (cartState.numDishes != null && cartState.numDishes! > 0)
                    ? AppColors.white
                    : AppColors.slate600,
                BlendMode.srcIn,
              ),
            ),
            if (cartState.numDishes != null && cartState.numDishes! > 0)
              Text(
                cartState.numDishes.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                  height: 1,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
