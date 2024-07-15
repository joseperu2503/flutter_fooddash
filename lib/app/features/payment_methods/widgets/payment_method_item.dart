import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/features/payment_methods/models/payment_methods.dart';
import 'package:fooddash/app/features/shared/widgets/custom_check.dart';
import 'package:flutter/material.dart';

class PaymentMethodItem extends StatelessWidget {
  const PaymentMethodItem({
    super.key,
    this.isSelected,
    this.onPress,
    required this.paymentMethod,
  });

  final bool? isSelected;
  final void Function()? onPress;
  final PaymentMethod paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xffD3D1D8).withOpacity(0.45),
            offset: const Offset(6, 8),
            blurRadius: 22.96,
            spreadRadius: 0,
          ),
        ],
      ),
      height: 80,
      child: TextButton(
        onPressed: onPress == null
            ? null
            : () {
                onPress!();
              },
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
        ),
        child: Row(
          children: [
            Image.network(
              paymentMethod.image,
              fit: BoxFit.contain,
              width: 50,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    paymentMethod.description,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.slate900,
                      height: 1,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                  if (paymentMethod.lastFourDigits != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        '**** **** **** ${paymentMethod.lastFourDigits}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.slate600,
                          height: 1,
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (isSelected != null)
              CustomCheck(
                isSelected: isSelected!,
              ),
          ],
        ),
      ),
    );
  }
}
