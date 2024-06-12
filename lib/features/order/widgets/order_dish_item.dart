import 'package:fooddash/config/constants/app_colors.dart';
import 'package:fooddash/features/restaurant/models/restaurant_detail.dart';
import 'package:flutter/material.dart';

const double heightItem = 90;

class OrderDishItem extends StatelessWidget {
  const OrderDishItem({
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
          ],
        ),
      ),
    );
  }
}
