import 'package:fooddash/config/constants/app_colors.dart';
import 'package:fooddash/features/payment_methods/models/card.dart';
import 'package:fooddash/features/shared/widgets/check.dart';
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
              'assets/icons/visa.svg',
              width: 50,
            ),
            const SizedBox(
              width: 12,
            ),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Debit card',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gray900,
                      height: 1,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '4929 **** **** 1976',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.gray600,
                      height: 1,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected != null)
              Check(
                isSelected: isSelected!,
              ),
          ],
        ),
      ),
    );
  }
}
