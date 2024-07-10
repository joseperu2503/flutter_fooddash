import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/config/constants/app_colors.dart';
import 'package:fooddash/features/order/models/order.dart';
import 'package:fooddash/features/order/screens/payment_screen.dart';
import 'package:fooddash/features/shared/utils/utils.dart';

class PaymentInfo extends StatelessWidget {
  const PaymentInfo({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xffD3D1D8).withOpacity(0.3),
            offset: const Offset(8, 12),
            blurRadius: 22.96,
            spreadRadius: 0,
          ),
        ],
      ),
      height: 80,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentScreen(
                order: order,
              ),
            ),
          );
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.label,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  Utils.formatCurrency(order.total),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray900,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
              ],
            ),
            const Spacer(),
            SvgPicture.asset(
              'assets/icons/arrow_forward.svg',
              width: 16,
            ),
          ],
        ),
      ),
    );
  }
}
