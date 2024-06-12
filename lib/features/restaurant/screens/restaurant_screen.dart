import 'package:flutter_fooddash/config/constants/app_colors.dart';
import 'package:flutter_fooddash/features/dashboard/providers/restaurants_provider.dart';
import 'package:flutter_fooddash/features/restaurant/data/constants.dart';
import 'package:flutter_fooddash/features/restaurant/models/restaurant_detail.dart';
import 'package:flutter_fooddash/features/restaurant/services/restaurant_services.dart';
import 'package:flutter_fooddash/features/dish/widgets/dish_item.dart';
import 'package:flutter_fooddash/features/restaurant/widgets/dish_categories.dart';
import 'package:flutter_fooddash/features/shared/widgets/image_app_bar.dart';
import 'package:flutter_fooddash/features/restaurant/widgets/restaurant_info.dart';
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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getRestaurant();
      _setVerticalBreakPoints();
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
  }

  List<DishCategory> get menu => restaurantDetail?.dishCategories ?? [];

  void _scrollToCategory(int index) async {
    if (selectedCategoryIndex != index) {
      setState(() {
        scrollType = ScrollType.tap;
        selectedCategoryIndex = index;
      });

      if (_categoryKeys[index].currentContext == null) return;
      await Scrollable.ensureVisible(
        _categoryKeys[index].currentContext!,
        alignment: 0.0,
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
    final double firstBreakPoint = _firstVerticalBreakPoint;
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
          RestaurantInfo(restaurant: restaurantDetail!),
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
                flexibleSpace: DishCategories(
                  onChanged: (value) {
                    _scrollToCategory(value);
                  },
                  selectedIndex: selectedCategoryIndex,
                  menu: menu,
                ),
                primary: false,
                toolbarHeight: heightCategories,
                scrolledUnderElevation: 0,
                automaticallyImplyLeading: false,
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
                      key: _categoryKeys[index],
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
