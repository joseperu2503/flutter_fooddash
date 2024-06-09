import 'package:delivery_app/features/dashboard/models/restaurant.dart';
import 'package:delivery_app/features/dashboard/providers/restaurants_provider.dart';
import 'package:delivery_app/features/restaurant/data/constants.dart';
import 'package:delivery_app/features/restaurant/data/menu.dart';
import 'package:delivery_app/features/restaurant/models/dish_category.dart';
import 'package:delivery_app/features/restaurant/widgets/menu_categories.dart';
import 'package:delivery_app/features/restaurant/widgets/menu_category_item.dart';
import 'package:delivery_app/features/restaurant/widgets/restaurant_appbar.dart';
import 'package:delivery_app/features/restaurant/widgets/restaurant_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ScrollType { tap, scroll }

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  RestaurantScreenState createState() => RestaurantScreenState();
}

class RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  final ScrollController verticalScrollController = ScrollController();
  ScrollType scrollType = ScrollType.scroll;

  double restaurantInfoHeight =
      expandedHeightAppbar + heightRestaurantInfo - collapsedHeightAppbar;

  int selectedCategoryIndex = 0;

  Restaurant? restaurant;

  List<DishCategory> menu = staticMenu;

  @override
  void initState() {
    final restaurants = ref.read(restaurantsProvider).restaurants;
    setState(() {
      restaurant = restaurants
          .firstWhere((element) => element.id.toString() == widget.id);
    });
    createBreakPoints();
    createHeightsCategories();

    verticalScrollController.addListener(() {
      updateCategoryIndexOnScroll(verticalScrollController.offset);

      // print('scroll actual ${verticalScrollController.offset}');
    });
    super.initState();
  }

  void scrollToCategory(int index) async {
    final altoPantalla = MediaQuery.of(context).size.height;

    if (selectedCategoryIndex != index) {
      setState(() {
        scrollType = ScrollType.tap;
        selectedCategoryIndex = index;
      });

      double totalScroll = (expandedHeightAppbar - collapsedHeightAppbar) +
          heightRestaurantInfo -
          (altoPantalla -
              heightCategories -
              kToolbarHeight -
              collapsedHeightAppbar);

      totalScroll += heightCategorySpace * (menu.length - 1);
      totalScroll += 3;
      totalScroll += heightEnd;

      for (var i = 0; i < menu.length; i++) {
        totalScroll += heightsCategories[i];
      }

      // print('totalscroll $totalScroll');

      double scrollRestante = heightCategorySpace * (menu.length - index - 1);
      for (var i = index; i < menu.length; i++) {
        scrollRestante += heightsCategories[i];
      }
      scrollRestante += heightEnd;

      if (scrollRestante <
          altoPantalla -
              kToolbarHeight -
              collapsedHeightAppbar -
              heightCategories) {
        await verticalScrollController.animateTo(
          totalScroll,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
        setState(() {
          scrollType = ScrollType.scroll;
        });

        return;
      }

      // print('scroll vertical hasta ${breakPoints[index]}');

      await verticalScrollController.animateTo(
        breakPoints[index],
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
      setState(() {
        scrollType = ScrollType.scroll;
      });
    }
  }

  List<double> breakPoints = [];
  List<double> heightsCategories = [];

  void createBreakPoints() {
    double firstBreakPoint = restaurantInfoHeight;

    breakPoints.add(firstBreakPoint);

    for (var i = 0; i < menu.length; i++) {
      double breakPoint = breakPoints.last +
          (heightCategorySpace +
              heightCategoryTitle +
              heightCategoryTitleSpace) +
          (heightDish * rowsPerDishes(menu[i].dishes.length)) +
          (rowsPerDishes(menu[i].dishes.length) - 1) * mainAxisSpacing;
      breakPoints.add(breakPoint);
    }
  }

  void createHeightsCategories() {
    for (var i = 0; i < menu.length; i++) {
      int numDishes = menu[i].dishes.length;
      int numRows = rowsPerDishes(numDishes);
      double height = numRows * heightDish +
          (numRows - 1) * mainAxisSpacing +
          (heightCategoryTitle + heightCategoryTitleSpace);

      heightsCategories.add(height);
    }
  }

  void updateCategoryIndexOnScroll(double offset) {
    if (scrollType == ScrollType.tap) return;

    for (var i = 0; i < menu.length; i++) {
      if (breakPoints[i] <= offset + heightCategorySpace &&
          offset < breakPoints[i + 1]) {
        if (selectedCategoryIndex != i) {
          setState(() {
            selectedCategoryIndex = i;
          });
        }
      }
    }
  }

  int rowsPerDishes(int numDishes) {
    return (numDishes / crossAxisCount).ceil();
  }

  @override
  void dispose() {
    verticalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: restaurant != null
          ? CustomScrollView(
              controller: verticalScrollController,
              slivers: [
                ImageAppBar(
                  title: restaurant!.name,
                  image: restaurant!.backdrop,
                  scrollController: verticalScrollController,
                  logoImage: restaurant!.logo,
                ),
                RestaurantInfo(restaurant: restaurant!),
                SliverPersistentHeader(
                  delegate: MenuCategories(
                    onChanged: (value) {
                      scrollToCategory(value);
                    },
                    selectedIndex: selectedCategoryIndex,
                    menu: menu,
                  ),
                  pinned: true,
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverList.separated(
                    itemCount: menu.length,
                    itemBuilder: (context, index) {
                      final category = menu[index];

                      return MenuCategoryItem(
                        category: category,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: heightCategorySpace,
                      );
                    },
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: heightEnd,
                  ),
                )
              ],
            )
          : Container(),
    );
  }
}
