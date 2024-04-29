import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:flutter/material.dart';

enum BoxShadowType { orange, gray, none }

List<BoxShadowStyle> boxShadows = [
  BoxShadowStyle(
    boxShadowType: BoxShadowType.orange,
    boxShadow: [
      BoxShadow(
        color: AppColors.orange.withOpacity(0.2),
        offset: const Offset(0, 8),
        blurRadius: 30,
        spreadRadius: 0,
      )
    ],
  ),
  BoxShadowStyle(
    boxShadowType: BoxShadowType.gray,
    boxShadow: [
      const BoxShadow(
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
    this.fontWeight = FontWeight.w600,
  });

  final void Function() onPressed;
  final String text;
  final BoxShadowType boxShadow;
  final double? width;
  final double height;
  final FontWeight fontWeight;

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
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        style: TextButton.styleFrom(
          minimumSize: Size(
            double.infinity,
            height,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          backgroundColor: AppColors.primary,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: fontWeight,
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
