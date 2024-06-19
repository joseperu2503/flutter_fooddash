import 'package:fooddash/config/constants/app_colors.dart';
import 'package:fooddash/features/cart/providers/cart_provider.dart';
import 'package:fooddash/features/dashboard/providers/restaurants_provider.dart';
import 'package:fooddash/features/dashboard/widgets/appbar.dart';
import 'package:fooddash/features/dashboard/widgets/categories.dart';
import 'package:fooddash/features/dashboard/widgets/input_search.dart';
import 'package:fooddash/features/dashboard/widgets/message.dart';
import 'package:fooddash/features/dashboard/widgets/most_popular.dart';
import 'package:fooddash/features/dashboard/widgets/restaurant_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(restaurantsProvider.notifier).initData();
      ref.read(restaurantsProvider.notifier).getRestaurants();
      ref.read(restaurantsProvider.notifier).getCategories();
      ref.read(cartProvider.notifier).getMyCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    final restaurantsState = ref.watch(restaurantsProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            const AppbarDashboard(),
            const MesageDashboard(),
            const InputSearchDashboard(),
            CategoriesDashboard(
              categories: restaurantsState.categories,
            ),
            MostPopular(
              restaurants: restaurantsState.restaurants,
            ),
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
                  final restaurant = restaurantsState.restaurants[index];
                  return RestaurantItem(restaurant: restaurant);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 28,
                  );
                },
                itemCount: restaurantsState.restaurants.length,
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
