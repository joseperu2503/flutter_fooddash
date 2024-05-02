import 'package:delivery_app/features/profile/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/features/shared/widgets/back_button.dart';
import 'package:delivery_app/features/shared/widgets/custom_button.dart';
import 'package:delivery_app/features/shared/widgets/custom_input.dart';

const double heightBottomSheet = 380;

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    Future.microtask(() {
      ref.invalidate(profileProvider);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);
    final MediaQueryData screen = MediaQuery.of(context);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 60,
            flexibleSpace: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                height: 60,
                child: const Row(
                  children: [
                    CustomBackButton(),
                    Spacer(),
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.input,
                        height: 1,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 38,
                      height: 38,
                    ),
                  ],
                ),
              ),
            ),
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 0,
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                height: 108,
                width: 108,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                ),
                child: Center(
                  child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.yellow,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.yellow.withOpacity(0.3),
                          offset: const Offset(0, 15),
                          blurRadius: 40,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/drawer/profile.svg',
                        width: 60,
                        colorFilter: const ColorFilter.mode(
                          AppColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                profileState.fullName.value ?? '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  height: 1,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 24,
                          right: 24,
                          top: 50,
                          bottom: 40,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'FullName',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.label,
                                height: 1,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            CustomInput(
                              value: profileState.fullName,
                              onChanged: (value) {
                                ref
                                    .read(profileProvider.notifier)
                                    .changeFullName(value);
                              },
                              hintText: 'Enter full name',
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            const Text(
                              'E-mail',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.label,
                                height: 16 / 16,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            CustomInput(
                              value: profileState.email,
                              onChanged: (value) {
                                ref
                                    .read(profileProvider.notifier)
                                    .changeEmail(value);
                              },
                              hintText: 'Enter e-mail',
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            const Text(
                              'Phone Number',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.label,
                                height: 16 / 16,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            CustomInput(
                              value: profileState.phone,
                              onChanged: (value) {
                                ref
                                    .read(profileProvider.notifier)
                                    .changePhone(value);
                              },
                              hintText: 'Enter phone',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            color: AppColors.white,
            padding: EdgeInsets.only(bottom: screen.padding.bottom),
            height: 110,
            child: Center(
              child: CustomButton(
                onPressed: () {
                  context.pop();
                },
                text: 'SAVE',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
