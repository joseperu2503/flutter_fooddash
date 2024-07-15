import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/features/dashboard/models/restaurant.dart';
import 'package:fooddash/app/features/dashboard/widgets/restaurant_item.dart';
import 'package:flutter/material.dart';

class MostPopular extends StatelessWidget {
  const MostPopular({
    super.key,
    required this.restaurants,
  });
  final List<Restaurant> restaurants;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 18,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: const Text(
              'The most popular',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.slate900,
                height: 1,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 190,
            child: ListView.separated(
              clipBehavior: Clip.none,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return RestaurantItem(
                  width: 250,
                  // height: 180,
                  restaurant: restaurant,
                  showLogo: false,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 28,
                );
              },
              itemCount: restaurants.length,
            ),
          )
        ],
      ),
    );
  }
}
