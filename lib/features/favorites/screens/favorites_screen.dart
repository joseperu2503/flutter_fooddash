import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/features/favorites/widgets/favorite_switch.dart';
import 'package:delivery_app/features/restaurant/data/constants.dart';
import 'package:delivery_app/features/restaurant/data/menu.dart';
import 'package:delivery_app/features/restaurant/widgets/dish_item.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  FavoriteType facoriteType = FavoriteType.food;

  @override
  Widget build(BuildContext context) {
    final dishes = menu[0].dishes;
    double deviceWidth = MediaQuery.of(context).size.width;
    final widthGridItem =
        (deviceWidth - 24 * 2 - crossAxisSpacing) / crossAxisCount;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          flexibleSpace: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            height: 60,
            child: const Row(
              children: [
                Spacer(),
                Text(
                  'Favorites',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColors.input,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom: 8,
              ),
              child: FavoriteSwitch(
                favoriteType: facoriteType,
                onChange: (value) {
                  setState(() {
                    facoriteType = value;
                  });
                },
                width: MediaQuery.of(context).size.width - 2 * 24,
              ),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 24,
                    ),
                    sliver: SliverGrid.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: mainAxisSpacing,
                        crossAxisSpacing: crossAxisSpacing,
                        childAspectRatio: widthGridItem / heightDish,
                      ),
                      itemBuilder: (context, index) {
                        return DishItem(
                          widthGridItem: widthGridItem,
                          dish: dishes[index],
                        );
                      },
                      itemCount: dishes.length,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum FavoriteType { food, restaurant }
