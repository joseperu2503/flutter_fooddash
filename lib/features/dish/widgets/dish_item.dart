import 'package:fooddash/config/constants/app_colors.dart';
import 'package:fooddash/features/cart/providers/cart_provider.dart';
import 'package:fooddash/features/dish/providers/dish_provider.dart';
import 'package:fooddash/features/restaurant/models/restaurant_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/features/shared/utils/utils.dart';
import 'package:go_router/go_router.dart';

class DishItem extends ConsumerWidget {
  const DishItem({
    super.key,
    required this.widthGridItem,
    required this.dish,
  });

  final double widthGridItem;
  final Dish dish;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);

    int unitsInCart = 0;

    for (var dishForRequest in cartState.dishesForCartRequest) {
      if (dishForRequest.dishId == dish.id) {
        unitsInCart = unitsInCart + dishForRequest.units;
      }
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: widthGridItem,
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onTap: () {
              ref.read(dishProvider.notifier).setTemporalDish(dish);
              context.push('/dish/${dish.id}');
            },
            contentPadding: EdgeInsets.zero,
            dense: true,
            minVerticalPadding: 0,
            title: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: widthGridItem,
                      height: widthGridItem,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Stack(
                              children: [
                                SizedBox.expand(
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/icons/logo.svg',
                                      width: 52,
                                      height: 52,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.gray100,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                                FadeInImage(
                                  width: widthGridItem,
                                  height: widthGridItem,
                                  image: NetworkImage(
                                    dish.image,
                                  ),
                                  fit: BoxFit.cover,
                                  placeholder: const AssetImage(
                                      'assets/images/transparent.png'),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 11,
                            child: Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                color: AppColors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/icons/tabs/heart_solid.svg',
                                  width: 15,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 11,
                        right: 11,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            dish.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                              height: 1,
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            dish.description,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.label,
                              height: 1.3,
                              leadingDistribution: TextLeadingDistribution.even,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: widthGridItem - 14,
                  left: 11,
                  child: Container(
                    height: 28,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(254, 114, 76, 0.2),
                          offset: Offset(0, 5.85),
                          blurRadius: 23.39,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          '4.5',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                            height: 1,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        SvgPicture.asset(
                          'assets/icons/star.svg',
                          width: 10,
                          colorFilter: const ColorFilter.mode(
                            AppColors.yellow,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        const Text(
                          '(25+)',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.label,
                            height: 1,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 11,
                  child: Container(
                    height: 29,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(254, 114, 76, 0.2),
                          offset: Offset(0, 5.85),
                          blurRadius: 23.39,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '\$',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primary,
                            height: 1,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                        Text(
                          Utils.formatCurrency(dish.price, withSymbol: false),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                            height: 1,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        if (unitsInCart > 0)
          Positioned(
            top: -10,
            right: -10,
            child: Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
              child: Center(
                child: Text(
                  unitsInCart.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
