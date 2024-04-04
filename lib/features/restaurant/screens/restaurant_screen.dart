import 'package:delivery_app/features/dashboard/data/restaurants.dart';
import 'package:delivery_app/features/restaurant/data/constants.dart';
import 'package:delivery_app/features/restaurant/data/menu.dart';
import 'package:delivery_app/features/restaurant/widgets/menu_categories.dart';
import 'package:delivery_app/features/restaurant/widgets/menu_category_item.dart';
import 'package:delivery_app/features/restaurant/widgets/restaurant_appbar.dart';
import 'package:delivery_app/features/restaurant/widgets/restaurant_info.dart';
import 'package:flutter/material.dart';

enum ScrollType { tap, scroll }

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  final ScrollController verticalScrollController = ScrollController();
  ScrollType scrollType = ScrollType.scroll;

  double restaurantInfoHeight =
      expandedHeightAppbar + heightRestaurantInfo - collapsedHeightAppbar;

  int selectedCategoryIndex = 0;

  @override
  void initState() {
    createBreakPoints();
    verticalScrollController.addListener(() {
      updateCategoryIndexOnScroll(verticalScrollController.offset);
      // print(kToolbarHeight);
      // print(
      //     'scroll maxScrollExtent ${scrollController.position.maxScrollExtent}');
      print('scroll actual ${verticalScrollController.offset}');
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

      for (var i = 0; i < menu.length; i++) {
        totalScroll += (menu[i].dishes.length * heightDishItem) +
            (heightCategoryTitle + heightCategoryTitleSpace);
      }

      print('totalscroll $totalScroll');

      double scrollRestante = heightCategorySpace * (menu.length - index - 1);
      for (var i = index; i < menu.length; i++) {
        scrollRestante += menu[i].dishes.length * heightDishItem +
            (heightCategoryTitle + heightCategoryTitleSpace);
      }

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

      int numDishes = 0;
      for (var i = 0; i < index; i++) {
        numDishes += menu[i].dishes.length;
      }
      final double scrollVertical = restaurantInfoHeight +
          (heightDishItem * numDishes) +
          (heightCategorySpace +
                  heightCategoryTitle +
                  heightCategoryTitleSpace) *
              index;

      print('scroll vertical hasta $scrollVertical');

      await verticalScrollController.animateTo(
        scrollVertical,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
      setState(() {
        scrollType = ScrollType.scroll;
      });
    }
  }

  List<double> breakPoints = [];

  void createBreakPoints() {
    double firstBreakPoint = restaurantInfoHeight +
        (heightCategorySpace + heightCategoryTitle + heightCategoryTitleSpace) +
        (heightDishItem * menu[0].dishes.length);

    breakPoints.add(firstBreakPoint);

    for (var i = 1; i < menu.length; i++) {
      double breakPoint = breakPoints.last +
          (heightCategorySpace +
              heightCategoryTitle +
              heightCategoryTitleSpace) +
          (heightDishItem * menu[i].dishes.length);
      breakPoints.add(breakPoint);
    }
  }

  void updateCategoryIndexOnScroll(double offset) {
    if (scrollType == ScrollType.tap) return;

    for (var i = 0; i < menu.length; i++) {
      if (i == 0) {
        if (offset < breakPoints.first && selectedCategoryIndex != 0) {
          setState(() {
            selectedCategoryIndex = 0;
          });
        }
      } else if (breakPoints[i - 1] <= offset && offset < breakPoints[i]) {
        if (selectedCategoryIndex != i) {
          setState(() {
            selectedCategoryIndex = i;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    verticalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final restaurant = restaurants[0];

    return Scaffold(
      body: CustomScrollView(
        controller: verticalScrollController,
        slivers: [
          ImageAppBar(
            title: restaurant.name,
            image: restaurant.image,
            scrollController: verticalScrollController,
          ),
          RestaurantInfo(restaurant: restaurant),
          SliverPersistentHeader(
            delegate: MenuCategories(
              onChanged: (value) {
                scrollToCategory(value);
              },
              selectedIndex: selectedCategoryIndex,
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
                  height: 10,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
