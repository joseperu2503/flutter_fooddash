import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/app/config/constants/app_colors.dart';

enum SocialButtonType { google, facebook }

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.onPressed,
    required this.type,
  });

  final void Function() onPressed;
  final SocialButtonType type;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      width: 147,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD3D1D8).withOpacity(0.25),
            offset: const Offset(18.59, 18.59),
            blurRadius: 40,
            spreadRadius: 0,
          )
        ],
      ),
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: AppColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (type == SocialButtonType.google)
              SvgPicture.asset(
                'assets/icons/google.svg',
                width: 38,
              ),
            if (type == SocialButtonType.facebook)
              SvgPicture.asset(
                'assets/icons/facebook.svg',
                width: 38,
              ),
            const SizedBox(
              width: 12,
            ),
            if (type == SocialButtonType.google)
              const Text(
                'Google',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                  height: 16 / 16,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
              ),
            if (type == SocialButtonType.facebook)
              const Text(
                'Facebook',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                  height: 16 / 16,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
