import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/features/shared/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: AppColors.slate300,
            child: Image.asset(
              'assets/images/background_home.jpeg',
              fit: BoxFit.cover,
              alignment: Alignment.topLeft,
              height: double.infinity,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF494D63).withOpacity(0),
                  const Color(0xFF191B2F)
                ],
              ),
            ),
          ),
          CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // SvgPicture.asset(
                        //   'assets/illustrations/home.svg',
                        //   fit: BoxFit.fitWidth,
                        // ),
                        const SizedBox(
                          height: 160,
                        ),
                        const Text(
                          'Welcome to',
                          style: TextStyle(
                            fontSize: 53,
                            fontWeight: FontWeight.w700,
                            color: AppColors.input,
                            height: 67.84 / 53,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                        const Text(
                          'FoodDash',
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                            height: 57.6 / 45,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                        const SizedBox(
                          height: 19,
                        ),
                        const Text(
                          'Your favourite foods delivered\nfast at your door.',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff30384F),
                            height: 27 / 18,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Spacer(),
                        CustomButton(
                          width: double.infinity,
                          onPressed: () {},
                          text: 'CREATE ACCOUNT',
                        ),
                        const SizedBox(
                          height: 23,
                        ),
                        SizedBox(
                          height: 60,
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              context.push('/login');
                            },
                            style: TextButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              side: const BorderSide(
                                color: AppColors.white,
                              ),
                              backgroundColor:
                                  AppColors.white.withOpacity(0.21),
                            ),
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                                height: 19 / 16,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
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
                              color: AppColors.white,
                            ),
                            children: <TextSpan>[
                              const TextSpan(
                                text: 'By ',
                              ),
                              const TextSpan(
                                text: 'Registering ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const TextSpan(
                                text: 'or  ',
                              ),
                              const TextSpan(
                                text: 'Login ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const TextSpan(
                                text: 'you have agree to these\n',
                              ),
                              TextSpan(
                                text: 'Terms and Conditions. ',
                                style: const TextStyle(
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
        ],
      ),
    );
  }
}
