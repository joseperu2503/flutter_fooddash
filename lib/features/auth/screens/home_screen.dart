import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/features/shared/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      'assets/illustrations/home.svg',
                      fit: BoxFit.fitWidth,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'Welcome to Super Foodo',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.gray900,
                        height: 1.5,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      'Lorem ipsum dolor sit amet consectetur. Ut cras\n pellentesque',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: AppColors.gray900,
                        height: 19 / 13,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                      width: double.infinity,
                      onPressed: () {},
                      text: 'CREATE ACCOUNT',
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          context.push('/login');
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          side: const BorderSide(
                            color: AppColors.primary,
                          ),
                          // backgroundColor: AppColors.primaryGreen,
                        ),
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                            height: 19 / 16,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 22 / 14,
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'By ',
                            style: TextStyle(color: AppColors.gray900),
                          ),
                          const TextSpan(
                            text: 'Registerin ',
                            style: TextStyle(
                              color: AppColors.gray900,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const TextSpan(
                            text: 'or  ',
                            style: TextStyle(color: AppColors.gray900),
                          ),
                          const TextSpan(
                            text: 'Login ',
                            style: TextStyle(
                              color: AppColors.gray900,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const TextSpan(
                            text: 'you have agree to these\n',
                            style: TextStyle(color: AppColors.gray900),
                          ),
                          TextSpan(
                            text: 'Terms and Conditions. ',
                            style: const TextStyle(
                              color: AppColors.gray900,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
