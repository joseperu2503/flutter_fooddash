import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/features/dashboard/data/restaurants.dart';
import 'package:delivery_app/features/dashboard/widgets/appbar.dart';
import 'package:delivery_app/features/dashboard/widgets/categories.dart';
import 'package:delivery_app/features/dashboard/widgets/input_search.dart';
import 'package:delivery_app/features/dashboard/widgets/message.dart';
import 'package:delivery_app/features/dashboard/widgets/most_popular.dart';
import 'package:delivery_app/features/dashboard/widgets/restaurant_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            const AppbarDashboard(),
            const MesageDashboard(),
            const InputSearchDashboard(),
            const CategoriesDashboard(),
            const MostPopular(),
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
                      'Recommended for you',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.label2,
                        height: 1,
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
                  final restaurant = restaurantsRecommended[index];
                  return RestaurantItem(restaurant: restaurant);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 28,
                  );
                },
                itemCount: restaurantsRecommended.length,
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
