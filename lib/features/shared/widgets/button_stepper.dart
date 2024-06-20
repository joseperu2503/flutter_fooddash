import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/config/constants/app_colors.dart';

class ButtonStepper extends ConsumerWidget {
  const ButtonStepper({
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.white,
        boxShadow: value > 0
            ? const [
                BoxShadow(
                  color: Color.fromRGBO(211, 209, 216, 0.3),
                  offset: Offset(5, 10), // Desplazamiento horizontal y vertical
                  blurRadius: 20, // Radio de desenfoque
                  spreadRadius: 0, // Extensión de la sombra
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          if (value > 0)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              height: 28,
              width: 28,
              child: GestureDetector(
                onTap: () {
                  if (onRemove == null) return;
                  onRemove!();
                },
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
          if (value > 0)
            Container(
              alignment: Alignment.center,
              width: 28,
              child: Text(
                value.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  height: 1,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
              ),
            ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            height: 28,
            width: 28,
            child: GestureDetector(
              onTap: () {
                if (onAdd == null) return;
                onAdd!();
              },
              child: SvgPicture.asset(
                'assets/icons/plus.svg',
                height: 20,
                colorFilter: ColorFilter.mode(
                  onAdd == null
                      ? AppColors.slate400
                      : value > 0
                          ? AppColors.primary
                          : AppColors.slate800,
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
