import 'package:fooddash/config/constants/app_colors.dart';
import 'package:fooddash/features/shared/widgets/check.dart';
import 'package:flutter/material.dart';

class CashItem extends StatelessWidget {
  const CashItem({
    super.key,
    this.isSelected,
    this.onPress,
  });

  final bool? isSelected;
  final void Function()? onPress;

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
        onPressed: onPress,
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
              'https://files.joseperezgil.com/images/delivery/cash.png',
              fit: BoxFit.contain,
              width: 50,
            ),
            const SizedBox(
              width: 12,
            ),
            const Text(
              'Cash',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.gray800,
                height: 16 / 16,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
            const Spacer(),
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
