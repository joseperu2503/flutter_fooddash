import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/features/dish/providers/dish_provider.dart';
import 'package:fooddash/app/features/dish/widgets/dish_bottom.dart';
import 'package:fooddash/app/features/dish/widgets/dish_info.dart';
import 'package:fooddash/app/features/dish/widgets/topping_category_item.dart';
import 'package:fooddash/app/features/shared/widgets/image_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DishScreen extends ConsumerStatefulWidget {
  const DishScreen({
    super.key,
    required this.dishId,
  });

  final String dishId;

  @override
  DishScreenState createState() => DishScreenState();
}

class DishScreenState extends ConsumerState<DishScreen> {
  final ScrollController verticalScrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(dishProvider.notifier).getDish(widget.dishId);
    });
    super.initState();
  }

  @override
  void dispose() {
    verticalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dishState = ref.watch(dishProvider);
    if (dishState.dishDetail == null) {
      return const Scaffold();
    }

    return Scaffold(
      body: CustomScrollView(
        controller: verticalScrollController,
        slivers: [
          ImageAppBar(
            title: dishState.dishDetail!.name,
            image: dishState.dishDetail!.image,
            scrollController: verticalScrollController,
            expandedHeightAppbar: 300,
          ),
          DishInfo(dish: dishState.dishDetail!),
          SliverList.separated(
            itemBuilder: (context, index) {
              final toppingCategory = dishState.toppingCategoriesStatus[index];
              return ToppingCategoryItem(
                toppingCategory: toppingCategory,
                onPressTopping: (topping, quantity) {
                  ref.read(dishProvider.notifier).onPressTopping(
                        toppingCategory: toppingCategory,
                        topping: topping,
                        newQuantity: quantity,
                      );
                },
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                color: AppColors.inputBorder,
                height: 1.0,
              );
            },
            itemCount: dishState.dishDetail!.toppingCategories.length,
          ),
        ],
      ),
      bottomNavigationBar: const BottomDish(),
    );
  }
}
