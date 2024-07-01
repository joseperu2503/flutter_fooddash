import 'package:fooddash/config/constants/app_colors.dart';
import 'package:fooddash/features/payment_methods/models/bank_card.dart';
import 'package:fooddash/features/shared/widgets/custom_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    this.isSelected,
    required this.onPress,
    required this.card,
  });

  final bool? isSelected;
  final void Function() onPress;
  final BankCard card;
  String get cardIcon {
    if (card.issuer == 'Mastercard') {
      return 'assets/icons/mastercard.svg';
    }

    if (card.issuer == 'Visa') {
      return 'assets/icons/visa.svg';
    }

    return '';
  }

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
        onPressed: () {
          onPress();
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
            SvgPicture.asset(
              cardIcon,
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
                    card.paymentMethod.paymentTypeId == 'debit_card'
                        ? 'Debit card'
                        : 'Credit card',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.slate900,
                      height: 1,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '**** **** **** ${card.lastFourDigits}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.slate600,
                      height: 1,
                      leadingDistribution: TextLeadingDistribution.even,
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
