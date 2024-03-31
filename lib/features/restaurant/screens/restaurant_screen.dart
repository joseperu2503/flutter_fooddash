import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/features/dashboard/data/restaurants.dart';
import 'package:delivery_app/features/dashboard/models/restaurant.dart';
import 'package:delivery_app/features/restaurant/data/menu.dart';
import 'package:delivery_app/features/restaurant/models/dish_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  final ScrollController scrollController = ScrollController();

  double restaurantInfoHeight = 200 //AppBar expadendHeight
      +
      90 // Restaurant info
      -
      kToolbarHeight;

  int selectedCategoryIndex = 0;

  @override
  void initState() {
    createBreakPoints();
    scrollController.addListener(() {
      updateCategoryIndexOnScroll(scrollController.offset);
    });
    super.initState();
  }

  void scrollToCategory(int index) {
    if (selectedCategoryIndex != index) {
      int totalItems = 0;
      for (var i = 0; i < index; i++) {
        totalItems += menu[i].dishes.length;
      }

      scrollController.animateTo(
        restaurantInfoHeight + (80 * totalItems) + (40 * index),
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
      setState(() {
        selectedCategoryIndex = index;
      });
    }
  }

  List<double> breakPoints = [];

  void createBreakPoints() {
    double firstBreakPoint =
        restaurantInfoHeight + 40 + (80 * menu[0].dishes.length);

    breakPoints.add(firstBreakPoint);

    for (var i = 1; i < menu.length; i++) {
      double breakPoint = breakPoints.last + 40 + (80 * menu[i].dishes.length);
      breakPoints.add(breakPoint);
    }
  }

  void updateCategoryIndexOnScroll(double offset) {
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
  Widget build(BuildContext context) {
    final restaurant = restaurants[0];

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          RestaurantAppBar(restaurant: restaurant),
          RestaurantDetail(restaurant: restaurant),
          SliverPersistentHeader(
            delegate: RestaurantCategories(
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

              // delegate: SliverChildBuilderDelegate(
              //   (context, index) {
              //     final category = menu[index];
              //     return Column(
              //       crossAxisAlignment: CrossAxisAlignment.stretch,
              //       children: [
              //         Text(category.name),
              //         const SizedBox(
              //           height: 10,
              //         ),
              //         Column(
              //           children: List.generate(
              //             category.dishes.length,
              //             (index) {
              //               return Row(
              //                 children: [
              //                   Image.network(
              //                     restaurant.image,
              //                     fit: BoxFit.cover,
              //                     height: 80,
              //                     width: 80,
              //                   ),
              //                   Text(category.dishes[index].name),
              //                 ],
              //               );
              //             },
              //           ),
              //         )
              //       ],
              //     );
              //   },
              //   childCount: menu.length,
              // ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuCategoryItem extends StatelessWidget {
  const MenuCategoryItem({
    super.key,
    required this.category,
  });

  final DishCategory category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 20,
          child: Text(
            category.name,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: List.generate(
            category.dishes.length,
            (index) {
              return Row(
                children: [
                  Image.network(
                    category.dishes[index].image,
                    fit: BoxFit.cover,
                    height: 80,
                    width: 80,
                  ),
                  Text(category.dishes[index].name),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}

class RestaurantCategories extends SliverPersistentHeaderDelegate {
  final ValueChanged<int> onChanged;
  final int selectedIndex;

  RestaurantCategories({
    required this.onChanged,
    required this.selectedIndex,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: 52,
      color: AppColors.white,
      child: Categories(
        onChanged: onChanged,
        selectedIndex: selectedIndex,
      ),
    );
  }

  @override
  double get maxExtent => 52;

  @override
  double get minExtent => 52;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class Categories extends StatefulWidget {
  const Categories({
    super.key,
    required this.onChanged,
    required this.selectedIndex,
  });

  final ValueChanged<int> onChanged;
  final int selectedIndex;

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Categories oldWidget) {
    controller.animateTo(
      80.0 * widget.selectedIndex,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          menu.length,
          (index) {
            return Padding(
              padding: const EdgeInsets.only(left: 8),
              child: TextButton(
                onPressed: () {
                  widget.onChanged(index);
                },
                style: TextButton.styleFrom(
                  foregroundColor: widget.selectedIndex == index
                      ? Colors.black
                      : Colors.black38,
                ),
                child: Text(
                  menu[index].name,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class RestaurantAppBar extends StatelessWidget {
  const RestaurantAppBar({
    super.key,
    required this.restaurant,
  });
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      titleSpacing: 0,
      title: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 38,
              height: 38,
              child: ElevatedButton(
                onPressed: () {
                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.zero,
                  elevation: 4,
                  surfaceTintColor: AppColors.white,
                ),
                child: SvgPicture.asset(
                  'assets/icons/arrow_down.svg',
                ),
              ),
            ),
            // Spacer(),
            // CartButton(),
          ],
        ),
      ),
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      pinned: true,
      backgroundColor: Colors.white,
      expandedHeight: 200,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          width: double.infinity,
          color: AppColors.gray600,
          child: Center(
            child: Image.network(
              restaurant.image,
              fit: BoxFit.cover,
              height: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}

class RestaurantDetail extends StatelessWidget {
  const RestaurantDetail({
    super.key,
    required this.restaurant,
  });
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        height: 90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Sabor Mexicano Grill',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.gray900,
                height: 1.5,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
            Row(
              children: [
                Text(
                  restaurant.record.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.yellow,
                    height: 20 / 14,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                SvgPicture.asset(
                  'assets/icons/star.svg',
                  width: 14,
                  colorFilter: const ColorFilter.mode(
                    AppColors.yellow,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  '(${restaurant.recordPeople})',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.gray500,
                    height: 20 / 14,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Container(
                  width: 3,
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: AppColors.gray300,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  '${restaurant.distance} Km',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.gray500,
                    height: 20 / 14,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Container(
                  width: 3,
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: AppColors.gray300,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  '${restaurant.time} min',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.gray500,
                    height: 20 / 14,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
