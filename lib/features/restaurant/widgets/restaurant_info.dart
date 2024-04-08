import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/features/dashboard/models/restaurant.dart';
import 'package:delivery_app/features/restaurant/data/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RestaurantInfo extends StatelessWidget {
  const RestaurantInfo({
    super.key,
    required this.restaurant,
  });
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            height: heightRestaurantInfo,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Sabor Mexicano Grill',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.gray900,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  '4102 Pretty View Lanonda',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.label,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 22,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 22,
                        decoration: BoxDecoration(
                          color: const Color(0xffF6F6F6),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Center(
                          child: Text(
                            restaurant.tags[index],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff8A8E9B),
                              height: 1,
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 8);
                    },
                    itemCount: restaurant.tags.length,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/delivery.svg',
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    const Text(
                      'Free delivery',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.label2,
                        height: 1,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    SvgPicture.asset(
                      'assets/icons/clock.svg',
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      '${restaurant.time} min',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.label2,
                        height: 1,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      restaurant.record.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                        height: 1,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    SvgPicture.asset(
                      'assets/icons/star.svg',
                      width: 14,
                      colorFilter: const ColorFilter.mode(
                        AppColors.yellow,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      '(${restaurant.recordPeople})',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.label,
                        height: 1,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
