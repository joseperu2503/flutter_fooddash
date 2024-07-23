import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/features/favorites/providers/favorite_restaurant_provider.dart';
import 'package:fooddash/app/features/restaurant/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/app/features/shared/widgets/favorite_button.dart';

class RestaurantInfo extends ConsumerWidget {
  const RestaurantInfo({
    super.key,
    required this.restaurant,
  });
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        // height: heightRestaurantInfo,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(211, 209, 216, 0.3),
                        offset: Offset(
                            5, 10), // Desplazamiento horizontal y vertical
                        blurRadius: 20, // Radio de desenfoque
                        spreadRadius: 0, // Extensión de la sombra
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: SizedBox(
                      child: Image.network(
                        restaurant.logo,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  restaurant.name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.slate900,
                    height: 1.2,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                const Spacer(),
                FavoriteButton(
                  onPress: () async {
                    await ref
                        .read(favoriteRestaurantProvider.notifier)
                        .toggleFavorite(restaurantId: restaurant.id);
                  },
                  isFavorite: restaurant.isFavorite,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              restaurant.address,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.label,
                height: 1,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            // SizedBox(
            //   height: 22,
            //   child: ListView.separated(
            //     shrinkWrap: true,
            //     scrollDirection: Axis.horizontal,
            //     itemBuilder: (context, index) {
            //       return Container(
            //         height: 22,
            //         decoration: BoxDecoration(
            //           color: const Color(0xffF6F6F6),
            //           borderRadius: BorderRadius.circular(5),
            //         ),
            //         padding: const EdgeInsets.symmetric(horizontal: 14),
            //         child: Center(
            //           child: Text(
            //             restaurant.tags[index],
            //             style: const TextStyle(
            //               fontSize: 12,
            //               fontWeight: FontWeight.w500,
            //               color: Color(0xff8A8E9B),
            //               height: 1,
            //               leadingDistribution: TextLeadingDistribution.even,
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //     separatorBuilder: (context, index) {
            //       return const SizedBox(width: 8);
            //     },
            //     itemCount: restaurant.tags.length,
            //   ),
            // ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/delivery.svg',
                  height: 16,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                const Text(
                  'Free delivery',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.label2,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.gray300,
                  ),
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/icons/clock.svg',
                  height: 16,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  '${restaurant.time} min',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.label2,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.gray300,
                  ),
                ),
                const Spacer(),
                Text(
                  restaurant.record.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.label2,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                SvgPicture.asset(
                  'assets/icons/star.svg',
                  width: 14,
                  colorFilter: const ColorFilter.mode(
                    AppColors.yellow,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  '(${restaurant.recordPeople})',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.label,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
