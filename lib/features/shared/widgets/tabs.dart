import 'package:delivery_app/features/address/widgets/address_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:delivery_app/config/constants/app_colors.dart';

// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart

class Tabs extends StatefulWidget {
  const Tabs({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<Tabs> createState() => TabsState();
}

class TabsState extends State<Tabs> {
  void _onTap(BuildContext context, int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  final _advancedDrawerController = AdvancedDrawerController();
  void handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  @override
  void initState() {
    _advancedDrawerController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isShowDrawer = _advancedDrawerController.value.visible;
    final MediaQueryData screen = MediaQuery.of(context);

    return AdvancedDrawer(
      controller: _advancedDrawerController,
      openScale: 0.6,
      openRatio: 0.6,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      drawer: SizedBox(
        width: double.infinity,
        child: CustomScrollView(
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
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.yellow,
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
                    const SizedBox(
                      height: 28,
                    ),
                    const Text(
                      'Farion Wick',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                        height: 1,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'farionwick@gmail.com',
                      style: TextStyle(
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
                    height: 57,
                    child: TextButton(
                      onPressed: () {
                        menuItem.onPress(context);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            menuItem.icon,
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Text(
                            menuItem.label,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                              height: 1,
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 0,
                  );
                },
                itemCount: menuItems.length,
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 36 + screen.padding.top,
                  bottom: 36 + screen.padding.bottom,
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
                        onPressed: () {},
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
                                leadingDistribution:
                                    TextLeadingDistribution.even,
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
      ),
      disabledGestures: widget.navigationShell.currentIndex != 0,
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xffF2EAEA),
              offset: Offset(-25, 19),
              blurRadius: 99,
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            isShowDrawer ? 28 : 0,
          ),
          child: Scaffold(
            body: widget.navigationShell,
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: AppColors.white,
              currentIndex: widget.navigationShell.currentIndex,
              onTap: (value) {
                _onTap(context, value);
              },
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              selectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              unselectedItemColor: AppColors.gray400,
              selectedItemColor: AppColors.primary,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: SvgPicture.asset(
                    'assets/icons/tabs/home_outlined.svg',
                    colorFilter: const ColorFilter.mode(
                      AppColors.gray400,
                      BlendMode.srcIn,
                    ),
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/tabs/home_solid.svg',
                    colorFilter: const ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'My Order',
                  icon: SvgPicture.asset(
                    'assets/icons/tabs/cart_outlined.svg',
                    colorFilter: const ColorFilter.mode(
                      AppColors.gray400,
                      BlendMode.srcIn,
                    ),
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/tabs/cart_solid.svg',
                    colorFilter: const ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Favorite',
                  icon: SvgPicture.asset(
                    'assets/icons/tabs/heart_outlined.svg',
                    colorFilter: const ColorFilter.mode(
                      AppColors.gray400,
                      BlendMode.srcIn,
                    ),
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/tabs/heart_solid.svg',
                    colorFilter: const ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Profile',
                  icon: SvgPicture.asset(
                    'assets/icons/tabs/profile_outlined.svg',
                    colorFilter: const ColorFilter.mode(
                      AppColors.gray400,
                      BlendMode.srcIn,
                    ),
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/tabs/profile_solid.svg',
                    colorFilter: const ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
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

List<MenuItem> menuItems = [
  MenuItem(
    label: 'My Profile',
    onPress: (context) {},
    icon: 'assets/icons/drawer/profile.svg',
  ),
  MenuItem(
    label: 'Addresses',
    onPress: (context) {
      showAddressBottomSheet(context);
    },
    icon: 'assets/icons/map_pin_solid.svg',
  ),
  MenuItem(
    label: 'Payment Methods',
    onPress: (context) {
      context.push('/payment-methods');
    },
    icon: 'assets/icons/drawer/payment.svg',
  ),
  MenuItem(
    label: 'Contact Us',
    onPress: (context) {},
    icon: 'assets/icons/drawer/contact.svg',
  ),
  MenuItem(
    label: 'Settings',
    onPress: (context) {},
    icon: 'assets/icons/drawer/settings.svg',
  ),
  MenuItem(
    label: 'Helps & FAQs',
    onPress: (context) {},
    icon: 'assets/icons/drawer/help.svg',
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
