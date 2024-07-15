import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/app/features/order/models/order.dart';

class ProgressOrder extends StatelessWidget {
  const ProgressOrder({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: order.orderStatus.id >= 1
                    ? AppColors.orange
                    : AppColors.gray200,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/order.svg',
                  width: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                      height: 2,
                      color: AppColors.gray200,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 2,
                        width: order.orderStatus.id >= 2
                            ? constraints.maxWidth
                            : order.orderStatus.id >= 1
                                ? constraints.maxWidth / 2
                                : 0,
                        color: AppColors.primary,
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: order.orderStatus.id >= 2
                    ? AppColors.orange
                    : AppColors.gray200,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/pot.svg',
                  width: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                      height: 2,
                      color: AppColors.gray200,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 2,
                        width: order.orderStatus.id >= 3
                            ? constraints.maxWidth
                            : order.orderStatus.id >= 2
                                ? constraints.maxWidth / 2
                                : 0,
                        color: AppColors.primary,
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: order.orderStatus.id >= 3
                    ? AppColors.orange
                    : AppColors.gray200,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/delivery.svg',
                  width: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                      height: 2,
                      color: AppColors.gray200,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 2,
                        width: order.orderStatus.id >= 4
                            ? constraints.maxWidth
                            : order.orderStatus.id >= 3
                                ? constraints.maxWidth / 2
                                : 0,
                        color: AppColors.primary,
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: order.orderStatus.id == 4
                    ? AppColors.orange
                    : AppColors.gray200,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/check_circle.svg',
                  width: 24,
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
    );
  }
}
