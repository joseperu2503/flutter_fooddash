import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:flutter/material.dart';

enum BoxShadowType { orange, gray, none }

List<BoxShadowStyle> boxShadows = [
  BoxShadowStyle(
    boxShadowType: BoxShadowType.orange,
    boxShadow: [
      BoxShadow(
        color: AppColors.orange.withOpacity(0.2),
        offset: Offset(0, 8),
        blurRadius: 30,
        spreadRadius: 0,
      )
    ],
  ),
  BoxShadowStyle(
    boxShadowType: BoxShadowType.gray,
    boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(122, 129, 190, 0.16),
        offset: Offset(0, 10),
        blurRadius: 40,
        spreadRadius: 0,
      )
    ],
  ),
  BoxShadowStyle(
    boxShadowType: BoxShadowType.none,
    boxShadow: null,
  ),
];

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.boxShadow = BoxShadowType.orange,
    this.width = 248,
    this.height = 60,
  });

  final void Function() onPressed;
  final String text;
  final BoxShadowType boxShadow;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final boxShadowStyle =
        boxShadows.firstWhere((b) => b.boxShadowType == boxShadow);

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        boxShadow: boxShadowStyle.boxShadow,
      ),
      child: FilledButton(
        onPressed: () {
          onPressed();
        },
        style: FilledButton.styleFrom(
          minimumSize: const Size(
            double.infinity,
            60,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          backgroundColor: AppColors.primary,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
            height: 15 / 15,
            leadingDistribution: TextLeadingDistribution.even,
          ),
        ),
      ),
    );
  }
}

class BoxShadowStyle {
  final BoxShadowType boxShadowType;
  final List<BoxShadow>? boxShadow;

  BoxShadowStyle({
    required this.boxShadowType,
    required this.boxShadow,
  });
}
