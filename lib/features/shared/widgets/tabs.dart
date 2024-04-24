import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart

class Tabs extends StatefulWidget {
  const Tabs({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  void _onTap(BuildContext context, int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  final _advancedDrawerController = AdvancedDrawerController();
  void _handleMenuButtonPressed() {
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

    return AdvancedDrawer(
      controller: _advancedDrawerController,
      openScale: 0.7,
      openRatio: 0.5,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      drawer: Container(),
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
