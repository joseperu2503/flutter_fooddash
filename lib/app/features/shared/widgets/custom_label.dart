import 'package:flutter/widgets.dart';
import 'package:fooddash/app/config/constants/app_colors.dart';

class CustomLabel extends StatelessWidget {
  const CustomLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.label,
          height: 16 / 16,
          leadingDistribution: TextLeadingDistribution.even,
        ),
      ),
    );
  }
}
