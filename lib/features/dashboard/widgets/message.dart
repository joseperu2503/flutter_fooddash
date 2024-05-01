import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:flutter/material.dart';

class MesageDashboard extends StatelessWidget {
  const MesageDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          top: 20,
        ),
        child: const Text(
          'What would you like to order',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: AppColors.label2,
            height: 1,
            leadingDistribution: TextLeadingDistribution.even,
          ),
        ),
      ),
    );
  }
}
