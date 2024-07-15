import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/config/constants/styles.dart';
import 'package:fooddash/app/features/cart/providers/cart_provider.dart';
import 'package:fooddash/app/features/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChangeOrder extends ConsumerWidget {
  const ChangeOrder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);

    return SizedBox(
      height: 300,
      width: double.infinity,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 0,
                right: 24,
                left: 24,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Do you want to change\nyour order?',
                    style: modalBottomSheetTitle,
                  ),
                  Divider(
                    color: AppColors.slate100,
                    height: 30,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 0,
                  right: 24,
                  left: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: AppColors.slate700,
                          height: 1.4,
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                        children: <TextSpan>[
                          const TextSpan(
                            text:
                                'You already have products added to your cart of ',
                          ),
                          TextSpan(
                            text: cartState.cartResponse?.restaurant.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.slate900,
                            ),
                          ),
                          const TextSpan(
                            text:
                                ', Do you want to remove these items and add new ones?',
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              context.pop(false);
                            },
                            style: TextButton.styleFrom(
                              minimumSize: const Size(
                                double.infinity,
                                60,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              side: const BorderSide(
                                color: AppColors.slate300,
                                width: 1.5,
                              ),
                            ),
                            child: const Text(
                              'Kepp it',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.slate900,
                                height: 16 / 16,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: CustomButton(
                            onPressed: () {
                              context.pop(true);
                            },
                            text: 'Yes, remove',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
