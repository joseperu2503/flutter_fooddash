import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/features/dashboard/widgets/restaurant_item.dart';
import 'package:fooddash/app/features/favorites/providers/favorite_dish_provider.dart';
import 'package:fooddash/app/features/favorites/providers/favorite_restaurant_provider.dart';
import 'package:fooddash/app/features/favorites/widgets/favorite_switch.dart';
import 'package:fooddash/app/features/restaurant/data/constants.dart';
import 'package:fooddash/app/features/dish/widgets/dish_item.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  FavoriteScreenState createState() => FavoriteScreenState();
}

class FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  int page = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(favoriteRestaurantProvider.notifier).initData();
      await ref.read(favoriteRestaurantProvider.notifier).getRestaurants();
      ref.read(favoriteDishProvider.notifier).initData();
      await ref.read(favoriteDishProvider.notifier).getDishes();
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

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    final widthGridItem =
        (deviceWidth - 24 * 2 - crossAxisSpacing) / crossAxisCount;

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
              horizontal: 24,
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
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom: 8,
              ),
              child: FavoriteSwitch(
                pageController: _pageController,
                width: MediaQuery.of(context).size.width - 2 * 24,
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
                          left: 24,
                          right: 24,
                          top: 24,
                        ),
                        sliver: SliverGrid.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            mainAxisSpacing: mainAxisSpacing,
                            crossAxisSpacing: crossAxisSpacing,
                            childAspectRatio: widthGridItem / heightDish,
                          ),
                          itemBuilder: (context, index) {
                            return DishItem(
                              widthGridItem: widthGridItem,
                              dish: favoriteDishState.dishes[index],
                            );
                          },
                          itemCount: favoriteDishState.dishes.length,
                        ),
                      )
                    ],
                  ),
                  CustomScrollView(
                    controller: _scrollControllerRestaurant,
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.only(
                          left: 24,
                          right: 24,
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

enum FavoriteType { dish, restaurant }
