import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/config/constants/sizes.dart';
import 'package:delivery_app/features/order/widgets/delivery_info.dart';
import 'package:delivery_app/features/order/widgets/order_dish_item.dart';
import 'package:delivery_app/features/order/widgets/order_id.dart';
import 'package:delivery_app/features/order/widgets/price_info.dart';
import 'package:delivery_app/features/order/widgets/progress_order.dart';
import 'package:delivery_app/features/restaurant/data/menu.dart';
import 'package:flutter/material.dart';

const double heightBottomSheet = 260;
const double radiusBottomSheet = 42;

class BottomModal extends StatelessWidget {
  const BottomModal({
    super.key,
    required this.screen,
  });
  final MediaQueryData screen;
  @override
  Widget build(BuildContext context) {
    final dishes = staticMenu[0].dishes;

    final double minHeight = (heightBottomSheet + screen.padding.bottom) /
        (screen.size.height - toolbarHeight - screen.padding.top);
    const double maxHeight = 0.7;

    return DraggableScrollableSheet(
      initialChildSize: minHeight,
      minChildSize: minHeight,
      maxChildSize: maxHeight,
      snap: true,
      snapSizes: [minHeight, maxHeight],
      builder: (context, scrollController) {
        return Container(
          height: heightBottomSheet + screen.padding.bottom,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusBottomSheet),
              topRight: Radius.circular(radiusBottomSheet),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(63, 76, 95, 0.12),
                offset: Offset(0, -4),
                blurRadius: 20,
                spreadRadius: 0,
              ),
            ],
          ),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
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
                      Center(
                        child: Container(
                          height: 10,
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColors.gray200,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const DeliveryInfo(),
                      const SizedBox(
                        height: 24,
                      ),
                      const Text(
                        'Food on the way',
                        style: TextStyle(
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
                      const ProgressOrder(),
                      const SizedBox(
                        height: 40,
                      ),
                      const PriceInfo(),
                      const SizedBox(
                        height: 24,
                      ),
                      const OrderId(),
                      const SizedBox(
                        height: 42,
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  bottom: MediaQuery.of(context).padding.bottom + 30,
                ),
                sliver: SliverList.separated(
                  itemBuilder: (context, index) {
                    final dish = dishes[index];

                    return OrderDishItem(dish: dish);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 32,
                    );
                  },
                  itemCount: dishes.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
