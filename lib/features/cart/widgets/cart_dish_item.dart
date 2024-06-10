import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/features/restaurant/models/restaurant_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const double heightItem = 90;

class CartDishItem extends StatelessWidget {
  const CartDishItem({
    super.key,
    required this.dish,
  });
  final Dish dish;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: EdgeInsets.zero,
      dense: true,
      minVerticalPadding: 0,
      title: SizedBox(
        height: heightItem,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                dish.image,
                fit: BoxFit.cover,
                height: heightItem,
                width: heightItem,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    dish.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                      height: 1,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    dish.description,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Color(0xff8C8A9D),
                      height: 1.3,
                      leadingDistribution: TextLeadingDistribution.even,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '\$${dish.price}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                          height: 1,
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: IconButton(
                      padding: EdgeInsetsDirectional.zero,
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/icons/close.svg',
                      ),
                    ),
                  ),
                  const Spacer(),
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
                        height: 30,
                        width: 30,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
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
                          color: AppColors.primary,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.orange.withOpacity(0.4),
                              offset: const Offset(0, 7),
                              blurRadius: 15,
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        height: 30,
                        width: 30,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/plus.svg',
                            height: 20,
                            colorFilter: const ColorFilter.mode(
                              AppColors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
