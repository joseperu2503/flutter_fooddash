import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/features/dish/data/toppings.dart';
import 'package:delivery_app/features/dish/models/dish_detail.dart';
import 'package:delivery_app/features/dish/providers/dish_provider.dart';
import 'package:delivery_app/features/dish/services/dish_service.dart';
import 'package:delivery_app/features/dish/widgets/dish_info.dart';
import 'package:delivery_app/features/shared/widgets/image_app_bar.dart';
import 'package:delivery_app/features/shared/widgets/check.dart';
import 'package:delivery_app/features/shared/widgets/custom_button.dart';
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
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 26,
                  ),
                  Text(
                    'Choice of Add On',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.label2,
                      height: 1,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            sliver: SliverList.separated(
              itemBuilder: (context, index) {
                final topping = toppings[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  minVerticalPadding: 0,
                  dense: true,
                  onTap: () {},
                  title: Row(
                    children: [
                      Text(
                        topping.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                          height: 16 / 16,
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '+\$${topping.price}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                          height: 1,
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Check(
                        isSelected: true,
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 0,
                );
              },
              itemCount: toppings.length,
            ),
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
