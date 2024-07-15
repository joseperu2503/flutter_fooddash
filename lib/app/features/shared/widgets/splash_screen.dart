import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/app/config/constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    required this.show,
  });

  final bool show;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool show = true;

  @override
  Widget build(BuildContext context) {
    if (!show) {
      return Container();
    }
    return FadeOut(
      animate: !widget.show,
      onFinish: (direction) {
        setState(() {
          show = false;
        });
      },
      child: Scaffold(
        body: Container(
          color: AppColors.primary,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 93,
                  height: 93,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xffDB4921).withOpacity(0.5),
                        offset: const Offset(0, 30),
                        blurRadius: 35,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/logo.svg',
                      width: 60,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'FoodDash',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                    height: 57.6 / 45,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
