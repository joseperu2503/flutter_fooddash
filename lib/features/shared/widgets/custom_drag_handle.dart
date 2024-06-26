import 'package:flutter/material.dart';
import 'package:fooddash/config/constants/app_colors.dart';

class CustomDragHandle extends StatelessWidget {
  const CustomDragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      alignment: Alignment.center,
      child: Container(
        width: 80,
        height: 10,
        decoration: BoxDecoration(
          color: AppColors.gray100,
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }
}
