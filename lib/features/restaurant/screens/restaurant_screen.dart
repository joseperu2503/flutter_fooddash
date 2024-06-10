import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/features/dashboard/providers/restaurants_provider.dart';
import 'package:delivery_app/features/restaurant/data/constants.dart';
import 'package:delivery_app/features/restaurant/models/restaurant_detail.dart';
import 'package:delivery_app/features/restaurant/services/restaurant_services.dart';
import 'package:delivery_app/features/restaurant/widgets/dish_item.dart';
import 'package:delivery_app/features/restaurant/widgets/menu_categories.dart';
import 'package:delivery_app/features/restaurant/widgets/restaurant_appbar.dart';
import 'package:delivery_app/features/restaurant/widgets/restaurant_info.dart';
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

class RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  final ScrollController _verticalScrollController = ScrollController();
  ScrollType scrollType = ScrollType.scroll;
  RestaurantDetail? restaurantDetail;

  int selectedCategoryIndex = 0;
  bool _loading = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getRestaurant();
    });
    _verticalScrollController.addListener(_updateCategoryIndexOnScroll);
    super.initState();
  }

  getRestaurant() async {
    //obtiene el restaurant temporal del provider
    final restaurantsState = ref.read(restaurantsProvider);
    final RestaurantDetail? termporalRestaurant =
        restaurantsState.termporalRestaurant;
    if (termporalRestaurant != null) {
      setState(() {
        restaurantDetail = termporalRestaurant;
      });
    } else {
      setState(() {
        _loading = true;
      });
    }

    try {
      final RestaurantDetail response = await RestaurantService.getRestaurant(
        restaurantId: widget.restaurantId,
      );
      setState(() {
        restaurantDetail = response;
      });
    } catch (e) {
      throw Exception(e);
    }
    setState(() {
      _loading = false;
    });
  }

  List<DishCategory> get menu => restaurantDetail?.dishCategories ?? [];

  void _scrollToCategory(int index) async {
    if (selectedCategoryIndex != index) {
      setState(() {
        scrollType = ScrollType.tap;
        selectedCategoryIndex = index;
      });

      if (categoryKeys[index].currentContext == null) return;
      await Scrollable.ensureVisible(
        categoryKeys[index].currentContext!,
        alignment: 0.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );

      setState(() {
        scrollType = ScrollType.scroll;
      });
    }
  }

  final List<double> _verticalBreakPoints = [];
  List<GlobalObjectKey> get categoryKeys {
    return menu
        .map((dishCategory) => GlobalObjectKey(dishCategory.id))
        .toList();
  }

  double _firstVerticalBreakPoint = 0;

  //** calcula el scroll por cada categoria */
  void _setVerticalBreakPoints() {
    double firstBreakPoint = _firstVerticalBreakPoint;

    _verticalBreakPoints.add(firstBreakPoint);

    for (var i = 0; i < menu.length; i++) {
      int numDishes = menu[i].dishes.length;
      int numRows = _rowsPerDishes(numDishes);

      double breakPoint = _verticalBreakPoints.last +
          (heightCategorySpace +
              heightCategoryTitle +
              heightCategoryTitleSpace) +
          (numRows * heightDish) +
          (numRows - 1) * mainAxisSpacing;
      _verticalBreakPoints.add(breakPoint);
    }
  }

  //** Actualiza el index  de la categoria actual segun el scroll */
  void _updateCategoryIndexOnScroll() {
    if (scrollType == ScrollType.tap) return;

    for (var i = 0; i < menu.length; i++) {
      if (_verticalBreakPoints[i] <=
              _verticalScrollController.offset + heightCategorySpace &&
          _verticalScrollController.offset < _verticalBreakPoints[i + 1]) {
        if (selectedCategoryIndex != i) {
          setState(() {
            selectedCategoryIndex = i;
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context);
    ;
    final widthGridItem =
        (screen.size.width - 24 * 2 - crossAxisSpacing) / crossAxisCount;
    if (restaurantDetail == null) {
      return const Scaffold();
    }

    return Scaffold(
      body: CustomScrollView(
        controller: _verticalScrollController,
        slivers: [
          ImageAppBar(
            title: restaurantDetail!.name,
            image: restaurantDetail!.backdrop,
            scrollController: _verticalScrollController,
            logoImage: restaurantDetail?.logo,
          ),
          SliverLayoutBuilder(
            builder: (context, constraints) {
              return RestaurantInfo(restaurant: restaurantDetail!);
            },
          ),
          if (menu.isNotEmpty)
            SliverLayoutBuilder(
              builder: (context, constraints) {
                // print(constraints.viewportMainAxisExtent);
                double firstVerticalBreakPoint =
                    constraints.precedingScrollExtent -
                        (collapsedHeightAppbar + screen.padding.top);
                if (firstVerticalBreakPoint != _firstVerticalBreakPoint) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      _firstVerticalBreakPoint = firstVerticalBreakPoint;
                    });
                    _setVerticalBreakPoints();
                  });
                }
                return SliverPersistentHeader(
                  delegate: MenuCategories(
                    onChanged: (value) {
                      _scrollToCategory(value);
                    },
                    selectedIndex: selectedCategoryIndex,
                    menu: menu,
                  ),
                  pinned: true,
                );
              },
            ),
          if (menu.isNotEmpty)
            ...menu
                .map((dishCategory) {
                  int index = menu.indexOf(dishCategory);
                  return [
                    SliverPadding(
                      key: categoryKeys[index],
                      padding: const EdgeInsets.symmetric(horizontal: 24),
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
                              fontWeight: FontWeight.w600,
                              color: AppColors.gray900,
                              height: 1.5,
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      sliver: SliverGrid.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: mainAxisSpacing,
                          crossAxisSpacing: crossAxisSpacing,
                          childAspectRatio: widthGridItem / heightDish,
                        ),
                        itemBuilder: (context, index) {
                          final dish = dishCategory.dishes[index];
                          // print(dish.id);
                          return DishItem(
                            widthGridItem: widthGridItem,
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
          const SliverToBoxAdapter(
            child: SizedBox(
              height: heightEnd,
            ),
          )
        ],
      ),
    );
  }
}
