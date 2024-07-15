import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/features/dashboard/models/restaurant.dart';
import 'package:fooddash/app/features/dashboard/providers/restaurants_provider.dart';
import 'package:fooddash/app/features/shared/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class RestaurantItem extends ConsumerWidget {
  const RestaurantItem({
    super.key,
    required this.restaurant,
    this.showLogo = true,
    this.height = 240,
    this.width = double.infinity,
  });

  final Restaurant restaurant;
  final bool showLogo;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref
            .read(restaurantsProvider.notifier)
            .setTemporalRestaurant(restaurant);
        context.push('/restaurant/${restaurant.id}');
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(211, 209, 216, 0.25),
              offset: Offset(15, 15),
              blurRadius: 30,
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SizedBox(
                  height: 140,
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
                        width: double.infinity,
                        height: double.infinity,
                        image: NetworkImage(
                          restaurant.backdrop,
                        ),
                        fit: BoxFit.cover,
                        placeholder:
                            const AssetImage('assets/images/transparent.png'),
                      ),
                      Positioned(
                        top: 10,
                        left: 11,
                        child: Container(
                          width: 69,
                          height: 28,
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
                              Text(
                                restaurant.record.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black,
                                  height: 1,
                                  leadingDistribution:
                                      TextLeadingDistribution.even,
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
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.label,
                                  height: 1,
                                  leadingDistribution:
                                      TextLeadingDistribution.even,
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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 14,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (showLogo)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: SizedBox(
                          height: 48,
                          width: 48,
                          child: Image.network(
                            restaurant.logo,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    if (showLogo)
                      const SizedBox(
                        width: 12,
                      ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            restaurant.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                              height: 1,
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
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
                              Text(
                                restaurant.delivery == 0
                                    ? 'Free delivery'
                                    : Utils.formatCurrency(restaurant.delivery),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff7E8392),
                                  height: 14 / 12,
                                  leadingDistribution:
                                      TextLeadingDistribution.even,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
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
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff7E8392),
                                  height: 14 / 12,
                                  leadingDistribution:
                                      TextLeadingDistribution.even,
                                ),
                              ),
                            ],
                          ),
                          // if (restaurant.tags.isNotEmpty)
                          //   const SizedBox(
                          //     height: 10,
                          //   ),
                          // if (restaurant.tags.isNotEmpty)
                          //   SizedBox(
                          //     height: 22,
                          //     child: ListView.separated(
                          //       scrollDirection: Axis.horizontal,
                          //       itemBuilder: (context, index) {
                          //         return Container(
                          //           height: 22,
                          //           decoration: BoxDecoration(
                          //             color: const Color(0xffF6F6F6),
                          //             borderRadius: BorderRadius.circular(5),
                          //           ),
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: 14),
                          //           child: Center(
                          //             child: Text(
                          //               restaurant.tags[index],
                          //               style: const TextStyle(
                          //                 fontSize: 12,
                          //                 fontWeight: FontWeight.w400,
                          //                 color: Color(0xff8A8E9B),
                          //                 height: 1,
                          //                 leadingDistribution:
                          //                     TextLeadingDistribution.even,
                          //               ),
                          //             ),
                          //           ),
                          //         );
                          //       },
                          //       separatorBuilder: (context, index) {
                          //         return const SizedBox(width: 8);
                          //       },
                          //       itemCount: restaurant.tags.length,
                          //     ),
                          //   )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
