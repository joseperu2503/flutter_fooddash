import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/features/shared/widgets/custom_progress_indicator.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    super.key,
    required this.onPress,
    required this.isFavorite,
  });

  final bool isFavorite;
  final Future<void> Function() onPress;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.transparent,
      ),
      child: TextButton(
        onPressed: () async {
          setState(() {
            loading = true;
          });
          await widget.onPress();
          setState(() {
            loading = false;
          });
        },
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Center(
          child: !loading
              ? SvgPicture.asset(
                  widget.isFavorite
                      ? 'assets/icons/heart_solid.svg'
                      : 'assets/icons/heart_outlined.svg',
                  width: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                )
              : const CustomProgressIndicator(
                  size: 20,
                ),
        ),
      ),
    );
  }
}
