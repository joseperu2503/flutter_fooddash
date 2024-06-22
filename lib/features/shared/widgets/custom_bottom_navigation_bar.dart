import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/config/constants/app_colors.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData screen = MediaQuery.of(context);

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xff3F4C5F).withOpacity(0.12),
            offset: const Offset(0, -4),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
      ),
      height: 60 + screen.padding.bottom,
      child: BottomNavigationBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        currentIndex: navigationShell.currentIndex,
        onTap: (value) {
          _onTap(context, value);
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.primary,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: SvgPicture.asset(
              'assets/icons/tabs/home_outlined.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.slate600,
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
            label: '',
            icon: SvgPicture.asset(
              'assets/icons/tabs/order_outlined.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.slate600,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/tabs/order_outlined.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: SvgPicture.asset(
              'assets/icons/tabs/heart_outlined.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.slate600,
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
            label: '',
            icon: SvgPicture.asset(
              'assets/icons/tabs/notification_outlined.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.slate600,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/tabs/notification_solid.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
