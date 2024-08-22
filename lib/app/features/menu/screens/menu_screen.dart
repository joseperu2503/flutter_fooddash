import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fooddash/app/config/constants/styles.dart';
import 'package:fooddash/app/features/auth/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends ConsumerState<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final MediaQueryData screen = MediaQuery.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 36 + screen.padding.top,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.yellow,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.yellow.withOpacity(0.25),
                          offset: const Offset(0, 8),
                          blurRadius: 40,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/profile_solid.svg',
                        width: 60,
                        colorFilter: const ColorFilter.mode(
                          AppColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Text(
                    authState.user?.fullName ?? '',
                    style: title,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    authState.user?.email ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff9EA1B1),
                      height: 1,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                  const SizedBox(
                    height: 43,
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            sliver: SliverList.separated(
              itemBuilder: (context, index) {
                final menuItem = menuItems[index];
                return SizedBox(
                  height: 64,
                  child: TextButton(
                    onPressed: () {
                      menuItem.onPress(context);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      shape: const LinearBorder(),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          menuItem.icon,
                          width: 24,
                          height: 24,
                          colorFilter: const ColorFilter.mode(
                            AppColors.gray900,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Text(
                          menuItem.label,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.gray900,
                            height: 1,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          'assets/icons/arrow_forward.svg',
                          width: 16,
                          colorFilter: const ColorFilter.mode(
                            AppColors.gray900,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Divider(
                    height: 0,
                    color: AppColors.gray100,
                  ),
                );
              },
              itemCount: menuItems.length,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 36,
                bottom: 36,
              ),
              child: Row(
                children: [
                  Container(
                    height: 43,
                    width: 117,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.orange.withOpacity(0.2),
                          offset: const Offset(0, 10),
                          blurRadius: 30,
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: TextButton(
                      onPressed: () {
                        ref.read(authProvider.notifier).logout();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        backgroundColor: AppColors.primary,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/logout.svg',
                          ),
                          const SizedBox(
                            width: 9,
                          ),
                          const Text(
                            'Log Out',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white,
                              height: 1,
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<MenuItem> menuItems = [
  MenuItem(
    label: 'My Profile',
    onPress: (context) {
      context.push('/profile');
    },
    icon: 'assets/icons/profile_outlined.svg',
  ),
  MenuItem(
    label: 'Addresses',
    onPress: (context) {
      context.push('/my-addresses');
    },
    icon: 'assets/icons/map_pin_outlined.svg',
  ),
  MenuItem(
    label: 'Payment Methods',
    onPress: (context) {
      context.push('/payment-methods');
    },
    icon: 'assets/icons/card.svg',
  ),
  MenuItem(
    label: 'Contact Us',
    onPress: (context) {},
    icon: 'assets/icons/contact.svg',
  ),
  MenuItem(
    label: 'Settings',
    onPress: (context) {},
    icon: 'assets/icons/settings.svg',
  ),
  MenuItem(
    label: 'Helps & FAQs',
    onPress: (context) {},
    icon: 'assets/icons/help.svg',
  ),
];

class MenuItem {
  String label;
  void Function(BuildContext context) onPress;
  String icon;
  MenuItem({
    required this.label,
    required this.onPress,
    required this.icon,
  });
}
