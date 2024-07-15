import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/features/address/providers/address_provider.dart';
import 'package:fooddash/app/features/cart/providers/cart_provider.dart';
import 'package:fooddash/app/features/dashboard/providers/restaurants_provider.dart';
import 'package:fooddash/app/features/dashboard/widgets/appbar.dart';
import 'package:fooddash/app/features/dashboard/widgets/categories.dart';
import 'package:fooddash/app/features/dashboard/widgets/input_search.dart';
import 'package:fooddash/app/features/dashboard/widgets/message.dart';
import 'package:fooddash/app/features/dashboard/widgets/most_popular.dart';
import 'package:fooddash/app/features/dashboard/widgets/restaurant_item.dart';
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
      ref.read(addressProvider.notifier).getMyAddresses(withSetAddress: true);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels + 100 >=
          _scrollController.position.maxScrollExtent) {
        ref.read(restaurantsProvider.notifier).getRestaurants();
      }
    });
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final restaurantsState = ref.watch(restaurantsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            const AppbarDashboard(),
            const MesageDashboard(),
            const InputSearchDashboard(),
            const CategoriesDashboard(),
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
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.slate900,
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
