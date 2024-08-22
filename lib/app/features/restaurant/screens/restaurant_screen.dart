import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/config/constants/styles.dart';
import 'package:fooddash/app/features/cart/providers/cart_provider.dart';
import 'package:fooddash/app/features/cart/widgets/cart_bottom_sheet_2.dart';
import 'package:fooddash/app/features/dashboard/providers/dashboard_provider.dart';
import 'package:fooddash/app/features/dish/widgets/dish_skeleton.dart';
import 'package:fooddash/app/features/restaurant/data/constants.dart';
import 'package:fooddash/app/features/restaurant/models/dish_category.dart';
import 'package:fooddash/app/features/dish/widgets/dish_item.dart';
import 'package:fooddash/app/features/shared/models/loading_status.dart';
import 'package:fooddash/app/features/shared/widgets/image_app_bar.dart';
import 'package:fooddash/app/features/restaurant/widgets/restaurant_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ScrollType { tap, scroll }

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({
    super.key,
    required this.restaurantId,
  });

  final String restaurantId;

  @override
  RestaurantScreenState createState() => RestaurantScreenState();
}

class RestaurantScreenState extends ConsumerState<RestaurantScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _verticalScrollController = ScrollController();
  ScrollType scrollType = ScrollType.scroll;
  TabController? _tabController;

  int selectedCategoryIndex = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(dashboardProvider.notifier)
          .getRestaurant(restaurantId: int.parse(widget.restaurantId));
      _tabController = TabController(length: menu.length, vsync: this);
      _setVerticalBreakPoints();
      _verticalScrollController.addListener(_updateCategoryIndexOnScroll);
    });
    super.initState();
  }

  List<DishCategory> get menu => ref.watch(dashboardProvider).dishCategories;

  void _scrollToCategory(int index) async {
    if (selectedCategoryIndex != index) {
      setState(() {
        scrollType = ScrollType.tap;
        selectedCategoryIndex = index;
      });

      if (_categoryKeys[index].currentContext == null) return;

      await _verticalScrollController.animateTo(
        _verticalBreakPoints[index],
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );

      setState(() {
        scrollType = ScrollType.scroll;
      });
    }
  }

  final GlobalKey _sliverKey = GlobalKey();

  List<GlobalObjectKey> get _categoryKeys {
    return menu
        .map((dishCategory) => GlobalObjectKey(dishCategory.id))
        .toList();
  }

  double _firstVerticalBreakPoint = 0;

  final List<double> _verticalBreakPoints = [];

  //** calcula los scrollbreakpoints de las categorias */
  void _setVerticalBreakPoints() {
    final screen = MediaQuery.of(context);

    final double firstBreakPoint = _firstVerticalBreakPoint;
    _verticalBreakPoints.add(firstBreakPoint);
    for (var i = 0; i < menu.length; i++) {
      int numDishes = menu[i].dishes.length;
      int numRows = _rowsPerDishes(numDishes);

      double breakPoint = _verticalBreakPoints.last +
          (heightCategorySpace +
              heightCategoryTitle +
              heightCategoryTitleSpace) +
          (numRows * heightGridDish(screen.size.width)) +
          (numRows - 1) * mainAxisSpacing;
      _verticalBreakPoints.add(breakPoint);
    }
  }

  //** Actualiza el index  de la categoria actual segun el scroll (optimizado)*/
  void _updateCategoryIndexOnScroll() {
    if (scrollType == ScrollType.tap) return;
    for (var i = 0; i < menu.length; i++) {
      if (_verticalBreakPoints[i] <=
              _verticalScrollController.offset + heightCategorySpace &&
          _verticalScrollController.offset + heightCategorySpace <
              _verticalBreakPoints[i + 1]) {
        if (selectedCategoryIndex != i) {
          setState(() {
            selectedCategoryIndex = i;
          });
          setState(() {
            _tabController?.animateTo(i);
          });
        }
      }
    }
  }

  int _rowsPerDishes(int numDishes) {
    return (numDishes / crossAxisCount).ceil();
  }

  @override
  void dispose() {
    _verticalScrollController.dispose();
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context);
    final restaurantState = ref.watch(dashboardProvider);
    final restaurant = restaurantState.restaurant;

    if (restaurant == null) {
      return const Scaffold();
    }
    final cartState = ref.watch(cartProvider);

    return Scaffold(
      body: CustomScrollView(
        controller: _verticalScrollController,
        slivers: [
          ImageAppBar(
            title: restaurant.name,
            image: restaurant.backdrop,
            scrollController: _verticalScrollController,
          ),
          RestaurantInfo(restaurant: restaurant),
          if (restaurantState.dishesStatus == LoadingStatus.success)
            SliverLayoutBuilder(
              key: _sliverKey,
              builder: (context, constraints) {
                double firstVerticalBreakPoint =
                    constraints.precedingScrollExtent -
                        (collapsedHeightAppbar + screen.padding.top);
                if (firstVerticalBreakPoint != _firstVerticalBreakPoint) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      _firstVerticalBreakPoint = firstVerticalBreakPoint;
                    });
                  });
                }
                return SliverAppBar(
                  flexibleSpace: Container(
                    alignment: Alignment.bottomCenter,
                    height: heightCategories,
                    child: (_tabController != null)
                        ? TabBar(
                            controller: _tabController,
                            isScrollable: true,
                            padding: const EdgeInsets.symmetric(
                              horizontal: horizontalPaddingMobile,
                            ),
                            labelPadding: EdgeInsets.zero,
                            onTap: (value) {
                              _scrollToCategory(value);
                            },
                            tabAlignment: TabAlignment.start,
                            indicatorColor: AppColors.primary,
                            indicatorWeight: 4,
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return AppColors.white.withOpacity(0.3);
                              }

                              return null;
                            }),
                            tabs: menu.map((dishCategory) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 16,
                                ),
                                child: Text(
                                  dishCategory.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.dark,
                                    height: 19.5 / 16,
                                    letterSpacing: 0.12,
                                    leadingDistribution:
                                        TextLeadingDistribution.even,
                                  ),
                                ),
                              );
                            }).toList(),
                          )
                        : null,
                  ),
                  primary: false,
                  toolbarHeight: heightCategories,
                  scrolledUnderElevation: 0,
                  automaticallyImplyLeading: false,
                  pinned: true,
                );
              },
            ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: heightCategorySpace,
            ),
          ),
          if (restaurantState.dishesStatus == LoadingStatus.success &&
              menu.isNotEmpty)
            ...menu
                .map((dishCategory) {
                  int index = menu.indexOf(dishCategory);
                  return [
                    SliverPadding(
                      key: _categoryKeys[index],
                      padding: const EdgeInsets.symmetric(
                        horizontal: horizontalPaddingMobile,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: Container(
                          height: heightCategoryTitle,
                          margin: const EdgeInsets.only(
                            bottom: heightCategoryTitleSpace,
                          ),
                          child: Text(
                            dishCategory.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.slate900,
                              height: 1.5,
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: horizontalPaddingMobile,
                      ),
                      sliver: SliverGrid.builder(
                        gridDelegate: dishSliverGridDelegate(screen.size.width),
                        itemBuilder: (context, index) {
                          final dish = dishCategory.dishes[index];
                          // print(dish.id);
                          return DishItem(
                            dish: dish,
                          );
                        },
                        itemCount: dishCategory.dishes.length,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: heightCategorySpace,
                      ),
                    ),
                  ];
                })
                .toList()
                .reduce((value, element) => [...value, ...element]),
          if (restaurantState.dishesStatus == LoadingStatus.loading)
            SliverPadding(
              padding: const EdgeInsets.only(
                left: horizontalPaddingMobile,
                right: horizontalPaddingMobile,
              ),
              sliver: SliverGrid.builder(
                gridDelegate: dishSliverGridDelegate(screen.size.width),
                itemBuilder: (context, index) {
                  return const DishSkeleton();
                },
                itemCount: 6,
              ),
            ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: heightEnd,
            ),
          )
        ],
      ),
      bottomSheet:
          (cartState.cartResponse != null) ? const CartBottomSheet2() : null,
    );
  }
}
