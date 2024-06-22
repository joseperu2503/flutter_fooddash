import 'package:fooddash/features/profile/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/features/shared/models/loading_status.dart';
import 'package:fooddash/features/shared/widgets/custom_text_field.dart';
import 'package:fooddash/config/constants/app_colors.dart';
import 'package:fooddash/features/shared/widgets/back_button.dart';
import 'package:fooddash/features/shared/widgets/custom_button.dart';

const double heightBottomSheet = 380;

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileProvider.notifier).initData();
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
                height: 20,
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
                          offset: const Offset(0, 8),
                          blurRadius: 20,
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
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 24,
                          right: 24,
                          top: 30,
                          bottom: 40,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextField(
                              label: 'Name',
                              value: profileState.name,
                              onChanged: (value) {
                                ref
                                    .read(profileProvider.notifier)
                                    .changeName(value);
                              },
                              hintText: 'Enter name',
                              keyboardType: TextInputType.name,
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            CustomTextField(
                              label: 'Surname',
                              value: profileState.surname,
                              onChanged: (value) {
                                ref
                                    .read(profileProvider.notifier)
                                    .changeSurname(value);
                              },
                              hintText: 'Enter surname',
                              keyboardType: TextInputType.name,
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            CustomTextField(
                              label: 'E-mail',
                              value: profileState.email,
                              onChanged: (value) {
                                ref
                                    .read(profileProvider.notifier)
                                    .changeEmail(value);
                              },
                              hintText: 'Enter e-mail',
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            CustomTextField(
                              label: 'Phone Number',
                              value: profileState.phone,
                              onChanged: (value) {
                                ref
                                    .read(profileProvider.notifier)
                                    .changePhone(value);
                              },
                              hintText: 'Enter phone',
                              keyboardType: TextInputType.phone,
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
          bottomNavigationBar: profileState.showButton
              ? Container(
                  color: AppColors.white,
                  padding: EdgeInsets.only(bottom: screen.padding.bottom),
                  height: 110,
                  child: Center(
                    child: CustomButton(
                      onPressed: () {
                        ref.read(profileProvider.notifier).submit();
                      },
                      disabled: profileState.buttonDisabled,
                      text: 'Save',
                      loading: profileState.loading == LoadingStatus.loading,
                    ),
                  ),
                )
              : null,
        ),
      ],
    );
  }
}
