import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/config/constants/styles.dart';
import 'package:fooddash/app/features/dashboard/widgets/restaurant_item.dart';
import 'package:fooddash/app/features/dish/widgets/dish_skeleton.dart';
import 'package:fooddash/app/features/favorites/providers/favorite_dish_provider.dart';
import 'package:fooddash/app/features/favorites/providers/favorite_restaurant_provider.dart';
import 'package:fooddash/app/features/restaurant/data/constants.dart';
import 'package:fooddash/app/features/dish/widgets/dish_item.dart';
import 'package:flutter/material.dart';
import 'package:fooddash/app/features/shared/models/loading_status.dart';
import 'package:fooddash/app/features/shared/widgets/custom_switch.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  FavoriteScreenState createState() => FavoriteScreenState();
}

class FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(favoriteRestaurantProvider.notifier).initData();
      ref.read(favoriteRestaurantProvider.notifier).getRestaurants();
      ref.read(favoriteDishProvider.notifier).initData();
      ref.read(favoriteDishProvider.notifier).getDishes();
    });
    _scrollControllerDish.addListener(() {
      if (_scrollControllerDish.position.pixels + 100 >=
          _scrollControllerDish.position.maxScrollExtent) {
        ref.read(favoriteDishProvider.notifier).getDishes();
      }
    });
    _scrollControllerRestaurant.addListener(() {
      if (_scrollControllerRestaurant.position.pixels + 100 >=
          _scrollControllerRestaurant.position.maxScrollExtent) {
        ref.read(favoriteRestaurantProvider.notifier).getRestaurants();
      }
    });
    super.initState();
  }

  final ScrollController _scrollControllerDish = ScrollController();
  final ScrollController _scrollControllerRestaurant = ScrollController();
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _scrollControllerDish.dispose();
    _scrollControllerRestaurant.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context);

    final favoriteRestaurantState = ref.watch(favoriteRestaurantProvider);
    final favoriteDishState = ref.watch(favoriteDishProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          flexibleSpace: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: horizontalPaddingMobile,
            ),
            height: 60,
            child: const Row(
              children: [
                Spacer(),
                Text(
                  'Favorites',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColors.input,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: horizontalPaddingMobile,
                right: horizontalPaddingMobile,
                top: 24,
                bottom: 8,
              ),
              child: CustomSwitch(
                pageController: _pageController,
                label1: 'Dishes',
                label2: 'Restaurants',
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {});
                },
                children: [
                  CustomScrollView(
                    controller: _scrollControllerDish,
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.only(
                          left: horizontalPaddingMobile,
                          right: horizontalPaddingMobile,
                          top: 24,
                        ),
                        sliver: SliverGrid.builder(
                          gridDelegate:
                              dishSliverGridDelegate(screen.size.width),
                          itemBuilder: (context, index) {
                            return DishItem(
                              dish: favoriteDishState.dishes[index],
                            );
                          },
                          itemCount: favoriteDishState.dishes.length,
                        ),
                      ),
                      if (favoriteDishState.loadingStatus ==
                          LoadingStatus.loading)
                        SliverPadding(
                          padding: const EdgeInsets.only(
                            left: horizontalPaddingMobile,
                            right: horizontalPaddingMobile,
                            top: 24,
                          ),
                          sliver: SliverGrid.builder(
                            gridDelegate:
                                dishSliverGridDelegate(screen.size.width),
                            itemBuilder: (context, index) {
                              return const DishSkeleton();
                            },
                            itemCount: 6,
                          ),
                        ),
                    ],
                  ),
                  CustomScrollView(
                    controller: _scrollControllerRestaurant,
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.only(
                          left: horizontalPaddingMobile,
                          right: horizontalPaddingMobile,
                          top: 24,
                          bottom: 24,
                        ),
                        sliver: SliverList.separated(
                          itemBuilder: (context, index) {
                            final restaurant =
                                favoriteRestaurantState.restaurants[index];
                            return RestaurantItem(restaurant: restaurant);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 28,
                            );
                          },
                          itemCount: favoriteRestaurantState.restaurants.length,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
