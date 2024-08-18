import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/config/router/app_router.dart';
import 'package:fooddash/app/features/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderSuccessfully extends StatelessWidget {
  const OrderSuccessfully({
    super.key,
    required this.orderId,
  });

  final int orderId;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            SvgPicture.asset(
              'assets/icons/success.svg',
            ),
            const Text(
              'Order Succesfully',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xff323643),
                height: 1,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Happy! Your food will be made immediately and\nwe will send it after it\'s finished by the courier, please\nwait a moment.',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColors.slate500,
                height: 1.4,
                leadingDistribution: TextLeadingDistribution.even,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            const Spacer(),
            CustomButton(
              onPressed: () {
                appRouter.go('/my-orders/track-order/$orderId');
              },
              text: 'Order Tracking',
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
