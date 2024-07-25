import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fooddash/app/features/shared/widgets/custom_progress_indicator.dart';

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
    this.boxShadowType = BoxShadowType.orange,
    this.width = 248,
    this.height = 60,
    this.fontWeight = FontWeight.w600,
    this.disabled = false,
    this.loading = false,
  });

  final void Function() onPressed;
  final String text;
  final BoxShadowType boxShadowType;
  final double? width;
  final double height;
  final FontWeight fontWeight;
  final bool disabled;
  final bool loading;

  Color get backgroundColor {
    if (disabled) {
      return AppColors.slate400;
    }
    return AppColors.primary;
  }

  List<BoxShadow>? get boxShadow {
    if (disabled) {
      return null;
    }

    final boxShadowStyle =
        boxShadows.firstWhere((b) => b.boxShadowType == boxShadowType);
    return boxShadowStyle.boxShadow;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        boxShadow: boxShadow,
      ),
      child: TextButton(
        onPressed: loading || disabled
            ? null
            : () {
                onPressed();
              },
        style: TextButton.styleFrom(
          minimumSize: Size(
            double.infinity,
            height,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: backgroundColor,
        ),
        child: loading
            ? const CustomProgressIndicator(
                color: AppColors.white,
                size: 24,
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: fontWeight,
                  color: AppColors.white,
                  height: 16 / 16,
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
