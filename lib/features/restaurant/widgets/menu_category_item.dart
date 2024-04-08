import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/features/restaurant/data/constants.dart';
import 'package:delivery_app/features/restaurant/models/dish_category.dart';
import 'package:delivery_app/features/restaurant/widgets/dish_item.dart';
import 'package:flutter/material.dart';

class MenuCategoryItem extends StatelessWidget {
  const MenuCategoryItem({
    super.key,
    required this.category,
  });

  final DishCategory category;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    final widthGridItem =
        (deviceWidth - 24 * 2 - crossAxisSpacing) / crossAxisCount;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: heightCategoryTitle,
          child: Text(
            category.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.gray900,
              height: 1.5,
              leadingDistribution: TextLeadingDistribution.even,
            ),
          ),
        ),
        const SizedBox(
          height: heightCategoryTitleSpace,
        ),
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
            childAspectRatio: widthGridItem / heightDish,
          ),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return DishItem(
              widthGridItem: widthGridItem,
              dish: category.dishes[index],
            );
          },
          itemCount: category.dishes.length,
        ),
      ],
    );
  }
}
