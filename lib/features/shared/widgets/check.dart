import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:flutter/material.dart';

class Check extends StatelessWidget {
  const Check({
    super.key,
    required this.isSelected,
  });

  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? AppColors.primary500 : AppColors.gray400,
          width: 1.5,
        ),
        shape: BoxShape.circle,
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 13,
                height: 13,
                decoration: const BoxDecoration(
                  color: AppColors.primary500,
                  shape: BoxShape.circle,
                ),
              ),
            )
          : null,
    );
  }
}
