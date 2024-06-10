import 'package:delivery_app/features/dashboard/providers/restaurants_provider.dart';
import 'package:delivery_app/features/restaurant/data/constants.dart';
import 'package:delivery_app/features/restaurant/models/restaurant_detail.dart';
import 'package:delivery_app/features/restaurant/services/restaurant_services.dart';
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
  bool loading = false;

  // double heightRestaurantInfo = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getRestaurant();
      _createHeightsCategories();
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
      //TODO:DESCOMENTAR
      setState(() {
        restaurantDetail = termporalRestaurant;
      });
    } else {
      setState(() {
        loading = true;
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
      loading = false;
    });
  }

  List<DishCategory> get menu => restaurantDetail?.dishCategories ?? [];

  void _scrollToCategory(int index) async {
    final altoPantalla = MediaQuery.of(context).size.height;

    if (selectedCategoryIndex != index) {
      setState(() {
        scrollType = ScrollType.tap;
        selectedCategoryIndex = index;
      });

      double totalScroll = (expandedHeightAppbar - collapsedHeightAppbar) +
          220 -
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
        await _verticalScrollController.animateTo(
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

      await _verticalScrollController.animateTo(
        verticalBreakPoints[index],
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
      setState(() {
        scrollType = ScrollType.scroll;
      });
    }
  }

  double categoryScroll = 0;

  List<double> verticalBreakPoints = [];
  List<double> heightsCategories = [];

  double _firstVerticalBreakPoint = 0;

  void _setVerticalBreakPoints() {
    double firstBreakPoint = _firstVerticalBreakPoint;

    verticalBreakPoints.add(firstBreakPoint);

    for (var i = 0; i < menu.length; i++) {
      int numDishes = menu[i].dishes.length;
      int numRows = _rowsPerDishes(numDishes);

      double breakPoint = verticalBreakPoints.last +
          (heightCategorySpace +
              heightCategoryTitle +
              heightCategoryTitleSpace) +
          (numRows * heightDish) +
          (numRows - 1) * mainAxisSpacing;
      verticalBreakPoints.add(breakPoint);
    }
  }

  //** calcular altura de cada dish category */
  void _createHeightsCategories() {
    for (var i = 0; i < menu.length; i++) {
      int numDishes = menu[i].dishes.length;
      int numRows = _rowsPerDishes(numDishes);
      double height = numRows * heightDish +
          (numRows - 1) * mainAxisSpacing +
          (heightCategoryTitle + heightCategoryTitleSpace);

      heightsCategories.add(height);
    }
  }

  //** Actualiza el index  de la categoria actual segun el scroll */
  void _updateCategoryIndexOnScroll() {
    if (scrollType == ScrollType.tap) return;

    for (var i = 0; i < menu.length; i++) {
      if (verticalBreakPoints[i] <=
              _verticalScrollController.offset + heightCategorySpace &&
          _verticalScrollController.offset < verticalBreakPoints[i + 1]) {
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
      ),
    );
  }
}
