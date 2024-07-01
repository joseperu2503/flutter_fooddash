import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/config/constants/app_colors.dart';
import 'package:flutter/material.dart';

enum CheckType { single, multiple }

class CustomCheck extends StatelessWidget {
  const CustomCheck({
    super.key,
    required this.isSelected,
    this.onChange,
    this.type = CheckType.single,
  });

  final bool isSelected;
  final void Function(bool isSelected)? onChange;
  final CheckType type;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onChange != null) {
          onChange!(!isSelected);
        }
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.slate800,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(
              type == CheckType.single ? 12 : 8,
            ),
            color: isSelected && type == CheckType.multiple
                ? AppColors.primary
                : null,
          ),
          child: isSelected
              ? type == CheckType.single
                  ? Center(
                      child: Container(
                        width: 13,
                        height: 13,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(254, 114, 76, 0.4),
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: SvgPicture.asset(
                        'assets/icons/check.svg',
                        width: 24,
                        colorFilter: const ColorFilter.mode(
                          AppColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    )
              : null,
        ),
      ),
    );
  }
}
