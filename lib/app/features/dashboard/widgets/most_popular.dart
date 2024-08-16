import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/config/constants/styles.dart';
import 'package:fooddash/app/features/dashboard/providers/restaurants_provider.dart';
import 'package:fooddash/app/features/dashboard/widgets/restaurant_item.dart';
import 'package:flutter/material.dart';
import 'package:fooddash/app/features/dashboard/widgets/restaurant_skeleton.dart';
import 'package:fooddash/app/features/shared/models/loading_status.dart';

class MostPopular extends ConsumerWidget {
  const MostPopular({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantsState = ref.watch(restaurantsProvider);

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
              style: subtitle,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 190,
            child: Row(
              children: [
                if (restaurantsState.restaurantsStatus == LoadingStatus.success)
                  Expanded(
                    child: ListView.separated(
                      clipBehavior: Clip.none,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final restaurant = restaurantsState.restaurants[index];
                        return RestaurantItem(
                          width: 250,
                          restaurant: restaurant,
                          showLogo: false,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 28,
                        );
                      },
                      itemCount: restaurantsState.restaurants.length,
                    ),
                  ),
                if (restaurantsState.restaurantsStatus == LoadingStatus.loading)
                  Expanded(
                    child: ListView.separated(
                      clipBehavior: Clip.none,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return const RestaurantSkeleton(
                          width: 250,
                          showLogo: false,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 28,
                        );
                      },
                      itemCount: 5,
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
