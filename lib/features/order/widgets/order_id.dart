import 'package:flutter_fooddash/config/constants/app_colors.dart';
import 'package:flutter/material.dart';

class OrderId extends StatelessWidget {
  const OrderId({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 65,
          height: 65,
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(11.48),
            boxShadow: [
              BoxShadow(
                color: const Color(0xffD3D1D8).withOpacity(0.45),
                offset: const Offset(11.48, 17.22),
                blurRadius: 22.96,
                spreadRadius: 0,
              ),
            ],
          ),
          child: SizedBox(
            width: 80,
            height: 80,
            child: Image.network(
              'https://www.edigitalagency.com.au/wp-content/uploads/starbucks-logo-png.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 18,
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '3 Items',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.label,
                height: 1,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Starbuck',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                height: 1,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
          ],
        ),
        const Spacer(),
        const Text(
          '#264100',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.orange,
            height: 1,
            leadingDistribution: TextLeadingDistribution.even,
          ),
        ),
      ],
    );
  }
}
