import 'package:flutter/services.dart';
import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/features/auth/providers/login_provider.dart';
import 'package:fooddash/app/features/auth/widgets/social_button.dart';
import 'package:fooddash/app/features/shared/models/loading_status.dart';
import 'package:fooddash/app/features/shared/widgets/back_button.dart';
import 'package:fooddash/app/features/shared/widgets/custom_button.dart';
import 'package:fooddash/app/features/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(loginProvider.notifier).initData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);

    return Stack(
      children: [
        AnnotatedRegion(
          value: const SystemUiOverlayStyle(
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          child: Container(
            color: AppColors.background,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    toolbarHeight: 60,
                    pinned: true,
                    scrolledUnderElevation: 0,
                    flexibleSpace: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -40,
                          left: -55,
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white,
                              border: Border.all(
                                color: AppColors.primary,
                                width: 36,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -90,
                          left: 0,
                          child: Container(
                            width: 175,
                            height: 175,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffFFECE7),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -109,
                          right: -90,
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        SafeArea(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 8,
                            ),
                            height: 60,
                            child: const Row(
                              children: [
                                CustomBackButton(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                              color: AppColors.slate900,
                              height: 43 / 36,
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomTextField(
                            label: 'E-mail',
                            hintText: 'Your email',
                            value: loginState.email,
                            onChanged: (value) {
                              ref
                                  .read(loginProvider.notifier)
                                  .changeEmail(value);
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          CustomTextField(
                            label: 'Password',
                            hintText: 'Your password',
                            value: loginState.password,
                            onChanged: (value) {
                              ref
                                  .read(loginProvider.notifier)
                                  .changePassword(value);
                            },
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (value) {
                              ref.read(loginProvider.notifier).login();
                            },
                            isPassword: true,
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          const Center(
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primary,
                                height: 1,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Center(
                            child: CustomButton(
                              onPressed: () {
                                ref.read(loginProvider.notifier).login();
                              },
                              text: 'Login',
                              boxShadowType: BoxShadowType.gray,
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: AppColors.gray300,
                                ),
                              ),
                              const SizedBox(
                                width: 18,
                              ),
                              const Text(
                                'Sign in with',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.gray700,
                                  height: 1,
                                  leadingDistribution:
                                      TextLeadingDistribution.even,
                                ),
                              ),
                              const SizedBox(
                                width: 18,
                              ),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: AppColors.gray300,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SocialButton(
                                onPressed: () {
                                  ref
                                      .read(loginProvider.notifier)
                                      .loginFacebook();
                                },
                                type: SocialButtonType.facebook,
                              ),
                              SocialButton(
                                onPressed: () {
                                  ref
                                      .read(loginProvider.notifier)
                                      .loginGoogle();
                                },
                                type: SocialButtonType.google,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (loginState.loading == LoadingStatus.loading)
          Container(
            color: AppColors.white.withOpacity(0.5),
          ),
      ],
    );
  }
}
