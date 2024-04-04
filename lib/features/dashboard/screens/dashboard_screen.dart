import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/features/dashboard/data/restaurants.dart';
import 'package:delivery_app/features/dashboard/widgets/appbar.dart';
import 'package:delivery_app/features/dashboard/widgets/categories.dart';
import 'package:delivery_app/features/dashboard/widgets/input_search.dart';
import 'package:delivery_app/features/dashboard/widgets/restaurant_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            const AppbarDashboard(),
            const InputSearchDashboard(),
            // const BannerDashboard(),
            const CategoriesDashboard(),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 18,
                    ),
                    Text(
                      'Recommended',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray900,
                        height: 1.5,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              sliver: SliverList.separated(
                itemBuilder: (context, index) {
                  final restaurant = restaurants[index];
                  return RestaurantItem(restaurant: restaurant);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 28,
                  );
                },
                itemCount: restaurants.length,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 24,
              ),
            )
          ],
        ),
      ),
    );
  }
}
