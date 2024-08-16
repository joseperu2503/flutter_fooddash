import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/app/config/constants/app_colors.dart';

class Rate extends StatelessWidget {
  const Rate({
    super.key,
    required this.value,
    required this.onChange,
  });

  final int value;
  final void Function(int value) onChange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onChange(index + 1);
            },
            child: SvgPicture.asset(
              index < value
                  ? 'assets/icons/star_outlined.svg'
                  : 'assets/icons/star_solid.svg',
              width: 32,
              colorFilter: const ColorFilter.mode(
                AppColors.orange,
                BlendMode.srcIn,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 10,
          );
        },
        itemCount: 5,
      ),
    );
  }
}
