import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/features/shared/widgets/custom_bottom_navigation_bar.dart';
import 'package:fooddash/app/features/shared/widgets/custom_drawer.dart';
import 'package:go_router/go_router.dart';

// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart

class InternalLayout extends ConsumerStatefulWidget {
  const InternalLayout({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  TabsState createState() => TabsState();
}

class TabsState extends ConsumerState<InternalLayout> {
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

    return AdvancedDrawer(
      controller: _advancedDrawerController,
      openScale: 0.6,
      openRatio: 0.6,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      drawer: const CustomDrawer(),
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
            bottomNavigationBar: CustomBottomNavigationBar(
              navigationShell: widget.navigationShell,
            ),
          ),
        ),
      ),
    );
  }
}
