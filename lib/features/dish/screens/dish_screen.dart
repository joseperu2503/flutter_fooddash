import 'package:fooddash/config/constants/app_colors.dart';
import 'package:fooddash/features/dish/models/dish_detail.dart';
import 'package:fooddash/features/dish/providers/dish_provider.dart';
import 'package:fooddash/features/dish/services/dish_service.dart';
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
      await getDish();
    });
    super.initState();
  }

  getDish() async {
    final DishDetail? termporalDish = ref.read(dishProvider).termporalDish;
    if (termporalDish != null) {
      setState(() {
        dishDetail = termporalDish;
      });
    }

    try {
      final DishDetail response = await DishService.getDish(
        dishId: widget.dishId,
      );
      setState(() {
        dishDetail = response;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  DishDetail? dishDetail;

  @override
  void dispose() {
    verticalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (dishDetail == null) {
      return const Scaffold();
    }

    return Scaffold(
      body: CustomScrollView(
        controller: verticalScrollController,
        slivers: [
          ImageAppBar(
            title: dishDetail!.name,
            image: dishDetail!.image,
            scrollController: verticalScrollController,
          ),
          DishInfo(dish: dishDetail!),
          SliverList.separated(
            itemBuilder: (context, index) {
              final toppingCategory = dishDetail!.toppingCategories[index];
              return ToppingCategoryItem(
                toppingCategory: toppingCategory,
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                color: AppColors.inputBorder,
                height: 1.0,
              );
            },
            itemCount: dishDetail!.toppingCategories.length,
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 70,
          child: Center(
            child: CustomButton(
              onPressed: () {},
              text: 'ADD TO CART',
            ),
          ),
        ),
      ),
    );
  }
}
