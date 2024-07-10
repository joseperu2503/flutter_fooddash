import 'dart:math';

import 'package:fooddash/config/constants/app_colors.dart';
import 'package:fooddash/config/constants/styles.dart';
import 'package:fooddash/features/order/models/order.dart';
import 'package:fooddash/features/order/widgets/delivery_info.dart';
import 'package:fooddash/features/order/widgets/payment_info.dart';
import 'package:fooddash/features/order/widgets/progress_order.dart';
import 'package:fooddash/features/order/widgets/restaurant_info.dart';
import 'package:flutter/material.dart';
import 'package:fooddash/features/shared/widgets/custom_drag_handle.dart';

const double minHeightBottomSheet = 250;
const double maxHeightBottomSheet = 530;

const double radiusBottomSheet = 42;

class BottomModal extends StatelessWidget {
  const BottomModal({
    super.key,
    required this.screen,
    required this.order,
  });
  final MediaQueryData screen;
  final Order order;

  @override
  Widget build(BuildContext context) {
    final double minHeight = (minHeightBottomSheet + screen.padding.bottom) /
        (screen.size.height - toolbarHeightOrder - screen.padding.top);
    final double maxHeight = min(
        0.9,
        maxHeightBottomSheet /
            (screen.size.height - toolbarHeightOrder - screen.padding.top));

    return DraggableScrollableSheet(
      initialChildSize: minHeight,
      minChildSize: minHeight,
      maxChildSize: maxHeight,
      snap: true,
      snapSizes: [minHeight, maxHeight],
      builder: (context, scrollController) {
        return Container(
          height: minHeightBottomSheet + screen.padding.bottom,
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
            physics: const ClampingScrollPhysics(),
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
                      const CustomDragHandle(),
                      Text(
                        order.orderStatus.name,
                        style: modalBottomSheetTitle,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ProgressOrder(
                        order: order,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const DeliveryInfo(),
                      const SizedBox(
                        height: 40,
                      ),
                      PaymentInfo(
                        order: order,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      RestaurantInfo(
                        order: order,
                      ),
                      const SizedBox(
                        height: 42,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
