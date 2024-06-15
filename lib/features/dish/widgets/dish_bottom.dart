import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/config/constants/app_colors.dart';
import 'package:fooddash/features/shared/widgets/custom_button.dart';

class BottomDish extends StatelessWidget {
  const BottomDish({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        height: 70,
        child: Row(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffEEF0F2),
                        offset: Offset(0, 20),
                        blurRadius: 30,
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  height: 40,
                  width: 40,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      shape: const OvalBorder(),
                      padding: EdgeInsets.zero,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/minus.svg',
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 32,
                  child: const Text(
                    '1',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                      height: 1,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffEEF0F2),
                        offset: Offset(0, 20),
                        blurRadius: 30,
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  height: 40,
                  width: 40,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      shape: const OvalBorder(),
                      padding: EdgeInsets.zero,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/plus.svg',
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: CustomButton(
                onPressed: () {},
                text: 'ADD TO CART',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
