import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/features/dish/models/dish.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/app/features/favorites/providers/favorite_dish_provider.dart';
import 'package:fooddash/app/features/shared/widgets/favorite_button.dart';

class DishInfo extends ConsumerWidget {
  const DishInfo({
    super.key,
    required this.dish,
  });
  final Dish dish;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    dish.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.slate900,
                      height: 1.2,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                ),
                FavoriteButton(
                  onPress: () async {
                    await ref
                        .read(favoriteDishProvider.notifier)
                        .toggleFavorite(dishId: dish.id);
                  },
                  isFavorite: dish.isFavorite,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              dish.description,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColors.slate600,
                height: 23 / 15,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            // Row(
            //   children: [
            //     Container(
            //       height: 17,
            //       width: 17,
            //       decoration: const BoxDecoration(
            //         boxShadow: [
            //           BoxShadow(
            //             color: Color.fromRGBO(255, 197, 41, 0.4),
            //             offset: Offset(0, 2.94),
            //             blurRadius: 9.81,
            //             spreadRadius: 0,
            //           ),
            //         ],
            //       ),
            //       child: SvgPicture.asset(
            //         'assets/icons/star.svg',
            //         width: 17,
            //         colorFilter: const ColorFilter.mode(
            //           AppColors.yellow,
            //           BlendMode.srcIn,
            //         ),
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 2,
            //     ),
            //     const Text(
            //       '4.5',
            //       style: TextStyle(
            //         fontSize: 14,
            //         fontWeight: FontWeight.w600,
            //         color: AppColors.black,
            //         height: 1,
            //         leadingDistribution: TextLeadingDistribution.even,
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 4,
            //     ),
            //     const Text(
            //       '(30+)',
            //       style: TextStyle(
            //         fontSize: 14,
            //         fontWeight: FontWeight.w400,
            //         color: AppColors.label,
            //         height: 1,
            //         leadingDistribution: TextLeadingDistribution.even,
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 6,
            //     ),
            //     const Text(
            //       'See Review',
            //       style: TextStyle(
            //         fontSize: 13,
            //         fontWeight: FontWeight.w400,
            //         color: AppColors.primary,
            //         height: 1,
            //         leadingDistribution: TextLeadingDistribution.even,
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 18,
            // ),
            Row(
              children: [
                const Text(
                  '\$',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                Text(
                  '${dish.price}',
                  style: const TextStyle(
                    fontSize: 31,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
