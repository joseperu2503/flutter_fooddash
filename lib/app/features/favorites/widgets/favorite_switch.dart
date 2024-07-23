import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/features/favorites/screens/favorites_screen.dart';
import 'package:flutter/material.dart';

class FavoriteSwitch extends StatelessWidget {
  const FavoriteSwitch({
    super.key,
    required this.favoriteType,
    required this.onChange,
    required this.width,
  });

  final FavoriteType favoriteType;
  final void Function(FavoriteType favoriteType) onChange;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xffF2EAEA),
        ),
      ),
      width: width,
      padding: const EdgeInsets.all(4),
      height: 55,
      child: Stack(
        children: [
          Positioned(
            left: favoriteType == FavoriteType.restaurant
                ? (width / 2) - 2 * 4
                : 0,
            top: 0,
            child: Container(
              width: (width - 2 * 4) / 2,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFFE724C),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    onChange(FavoriteType.dish);
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'Dishes',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: favoriteType == FavoriteType.dish
                            ? const Color(0xffEFEFEF)
                            : AppColors.orange,
                        height: 1,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    onChange(FavoriteType.restaurant);
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'Restaurants',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: favoriteType == FavoriteType.restaurant
                            ? const Color(0xffEFEFEF)
                            : AppColors.orange,
                        height: 1,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
