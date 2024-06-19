import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/config/constants/app_colors.dart';

class ButtonStepper2 extends ConsumerWidget {
  const ButtonStepper2({
    super.key,
    required this.value,
    this.onAdd,
    this.onRemove,
  });

  final int value;
  final void Function()? onAdd;
  final void Function()? onRemove;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 30,
      width: 200,
      child: Row(
        children: [
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffEEF0F2),
                  offset: Offset(0, 20),
                  blurRadius: 30,
                  spreadRadius: 0,
                )
              ],
            ),
            height: 30,
            width: 30,
            child: TextButton(
              onPressed: () {
                if (onRemove == null || value == 0) return;
                onRemove!();
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.zero,
              ),
              child: SvgPicture.asset(
                'assets/icons/minus.svg',
                height: 20,
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 32,
            child: Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                height: 1,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary,
              ),
              color: AppColors.primary,
              boxShadow: [
                BoxShadow(
                  color: AppColors.orange.withOpacity(0.4),
                  offset: const Offset(0, 7),
                  blurRadius: 15,
                  spreadRadius: 0,
                )
              ],
            ),
            height: 30,
            width: 30,
            child: TextButton(
              onPressed: () {
                if (onAdd == null) return;
                onAdd!();
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.zero,
              ),
              child: SvgPicture.asset(
                'assets/icons/plus.svg',
                height: 20,
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
