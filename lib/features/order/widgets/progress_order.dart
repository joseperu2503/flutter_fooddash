import 'package:fooddash/config/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProgressOrder extends StatelessWidget {
  const ProgressOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 60,
              child: SvgPicture.asset(
                'assets/icons/order.svg',
                width: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                height: 1,
                color: AppColors.primary,
              ),
            ),
            SizedBox(
              width: 60,
              child: SvgPicture.asset(
                'assets/icons/pot.svg',
                width: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                height: 1,
                color: AppColors.primary,
              ),
            ),
            SizedBox(
              width: 60,
              child: SvgPicture.asset(
                'assets/icons/delivery.svg',
                width: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                height: 1,
                color: AppColors.label,
              ),
            ),
            SizedBox(
              width: 60,
              child: SvgPicture.asset(
                'assets/icons/check_circle.svg',
                width: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.label,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        const Row(
          children: [
            SizedBox(
              width: 60,
              child: Text(
                '1:30 pm',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.label,
                  height: 1,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: 60,
              child: Text(
                '1:40 pm',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.label,
                  height: 1,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: 60,
              child: Text(
                '1:45 pm',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.label,
                  height: 1,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: 60,
              child: Text(
                '2:20 pm',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.label,
                  height: 1,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
