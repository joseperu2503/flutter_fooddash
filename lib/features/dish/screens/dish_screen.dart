import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/config/constants/app_colors.dart';
import 'package:fooddash/features/dish/providers/dish_provider.dart';
import 'package:fooddash/features/dish/widgets/dish_info.dart';
import 'package:fooddash/features/dish/widgets/topping_category_item.dart';
import 'package:fooddash/features/shared/widgets/image_app_bar.dart';
import 'package:fooddash/features/shared/widgets/custom_button.dart';
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
          ),
          DishInfo(dish: dishState.dishDetail!),
          SliverList.separated(
            itemBuilder: (context, index) {
              final toppingCategory =
                  dishState.dishDetail!.toppingCategories[index];
              return ToppingCategoryItem(
                toppingCategory: toppingCategory,
                onPressTopping: (topping, quantity) {
                  ref.read(dishProvider.notifier).onPressTopping(
                        toppingCategory: toppingCategory,
                        topping: topping,
                        newQuantity: quantity,
                      );
                },
                selectedToppings: dishState.selectedToppings,
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
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          height: 70,
          child: Row(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xffEEF0F2),
                          offset: Offset(0, 20),
                          blurRadius: 30,
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    height: 40,
                    width: 40,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        shape: const OvalBorder(),
                        padding: EdgeInsets.zero,
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/minus.svg',
                        height: 20,
                        colorFilter: const ColorFilter.mode(
                          AppColors.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 32,
                    child: const Text(
                      '1',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                        height: 1,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xffEEF0F2),
                          offset: Offset(0, 20),
                          blurRadius: 30,
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    height: 40,
                    width: 40,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        shape: const OvalBorder(),
                        padding: EdgeInsets.zero,
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/plus.svg',
                        height: 20,
                        colorFilter: const ColorFilter.mode(
                          AppColors.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 24,
              ),
              Expanded(
                child: CustomButton(
                  onPressed: () {},
                  text: 'ADD TO CART',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
