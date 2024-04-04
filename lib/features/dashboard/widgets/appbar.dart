import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AppbarDashboard extends StatelessWidget {
  const AppbarDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 60,
      floating: true,
      flexibleSpace: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primary50,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/map_pin.svg',
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Current location',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.gray500,
                        height: 1.5,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
                Text(
                  'Jl. Soekarno Hatta 15A...',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray900,
                    height: 1.5,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              height: 38,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19),
                color: AppColors.primary500,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary500,
                  elevation: 3,
                ),
                onPressed: () {
                  context.push('/cart');
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/tabs/cart_outlined.svg',
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    const Text(
                      '1',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                        height: 1,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
