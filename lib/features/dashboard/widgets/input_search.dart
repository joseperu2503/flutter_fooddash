import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputSearchDashboard extends StatelessWidget {
  const InputSearchDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.white,
      automaticallyImplyLeading: false,
      toolbarHeight: 70,
      pinned: true,
      flexibleSpace: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        height: 70,
        child: Center(
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: AppColors.gray300,
              ),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/search.svg',
                ),
                const SizedBox(
                  width: 8,
                ),
                const Expanded(
                  child: Text(
                    'Search menu, restaurant or etc',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.gray600,
                      height: 1.5,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  'assets/icons/tune.svg',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
