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
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        height: heightRestaurantInfo,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Sabor Mexicano Grill',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.gray900,
                height: 1.5,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Time',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.gray500,
                            height: 1.5,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        SvgPicture.asset(
                          'assets/icons/clock.svg',
                          height: 16,
                          colorFilter: const ColorFilter.mode(
                            AppColors.gray300,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${restaurant.time} min',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.gray800,
                        height: 1.5,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  width: 3,
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: AppColors.gray300,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Delivery',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.gray500,
                            height: 1.5,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        SvgPicture.asset(
                          'assets/icons/delivery.svg',
                          height: 16,
                          colorFilter: const ColorFilter.mode(
                            AppColors.gray300,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '\$4.99',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.gray800,
                        height: 1.5,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  width: 3,
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: AppColors.gray300,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Distance',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.gray500,
                            height: 1.5,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        SvgPicture.asset(
                          'assets/icons/map_pin.svg',
                          height: 16,
                          colorFilter: const ColorFilter.mode(
                            AppColors.gray300,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${restaurant.distance} Km',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.gray800,
                        height: 1.5,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  width: 3,
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: AppColors.gray300,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Rating',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.gray500,
                            height: 1.5,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        SvgPicture.asset(
                          'assets/icons/star.svg',
                          height: 12,
                          colorFilter: const ColorFilter.mode(
                            AppColors.gray300,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          restaurant.record.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.gray800,
                            height: 1.5,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          '(${restaurant.recordPeople})',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.gray500,
                            height: 1.5,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
