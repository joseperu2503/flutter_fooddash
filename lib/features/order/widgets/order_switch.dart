import 'package:fooddash/config/constants/app_colors.dart';
import 'package:fooddash/features/order/screens/my_orders_screen.dart';
import 'package:flutter/material.dart';

class OrderSwitch extends StatelessWidget {
  const OrderSwitch({
    super.key,
    required this.orderType,
    required this.onChange,
    required this.width,
  });

  final OrderType orderType;
  final void Function(OrderType orderType) onChange;
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
            left: orderType == OrderType.history ? (width / 2) - 2 * 4 : 0,
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
                    onChange(OrderType.upcoming);
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'Upcoming',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: orderType == OrderType.upcoming
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
                    onChange(OrderType.history);
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'History',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: orderType == OrderType.history
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
