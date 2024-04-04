import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/features/dashboard/data/restaurants.dart';
import 'package:delivery_app/features/restaurant/data/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dishes = menu[0].dishes;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          flexibleSpace: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            height: 60,
            child: Row(
              children: [
                SizedBox(
                  width: 38,
                  height: 38,
                  child: ElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.zero,
                      elevation: 4,
                      surfaceTintColor: AppColors.white,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/arrow_down.svg',
                    ),
                  ),
                ),
                const Spacer(),
                const Text(
                  'My Order',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray800,
                    height: 1.3,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                const Spacer(),
                const SizedBox(
                  width: 38,
                  height: 38,
                ),
              ],
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverList.separated(
              itemBuilder: (context, index) {
                return Container();
              },
              separatorBuilder: (context, index) {
                return Container();
              },
              itemCount: dishes.length,
            ),
          ],
        ),
      ),
    );
  }
}
