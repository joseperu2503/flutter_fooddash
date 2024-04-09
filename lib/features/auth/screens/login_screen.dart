import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/features/auth/providers/auth_provider.dart';
import 'package:delivery_app/features/shared/widgets/back_button.dart';
import 'package:delivery_app/features/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.white,
                toolbarHeight: 60,
                flexibleSpace: Stack(
                  children: [
                    Positioned(
                      top: -40,
                      left: -46,
                      child: Container(
                        width: 120,
                        height: 120,
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
                        width: 165,
                        height: 165,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.orange20,
                        ),
                      ),
                    ),
                    Positioned(
                      top: -109,
                      right: -90,
                      child: Container(
                        width: 181,
                        height: 181,
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
                child: SafeArea(
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
                            color: AppColors.gray900,
                            height: 43 / 36,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                        const SizedBox(
                          height: 0,
                        ),
                        const Text(
                          'Please login with registered account',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.gray400,
                            height: 1.5,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          'E-mail',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.label,
                            height: 16 / 16,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 65,
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(233, 233, 233, 0.25),
                                offset: Offset(15, 20),
                                blurRadius: 45,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.inputBorder,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.primary,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Your email',
                              hintStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: AppColors.inputHint,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: AppColors.input,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 29,
                        ),
                        const Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.label,
                            height: 16 / 16,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 65,
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(233, 233, 233, 0.25),
                                offset: Offset(15, 20),
                                blurRadius: 45,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.inputBorder,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.primary,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Your password',
                              hintStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: AppColors.inputHint,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: AppColors.input,
                            ),
                          ),
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
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Center(
                          child: CustomButton(
                            onPressed: () {
                              ref
                                  .read(authProvider.notifier)
                                  .setAuthStatus(AuthStatus.authenticated);
                            },
                            text: 'LOGIN',
                            boxShadow: BoxShadowType.gray,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
