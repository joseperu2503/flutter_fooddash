import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/features/restaurant/data/constants.dart';
import 'package:delivery_app/features/restaurant/data/menu.dart';
import 'package:flutter/material.dart';

class MenuCategories extends SliverPersistentHeaderDelegate {
  final ValueChanged<int> onChanged;
  final int selectedIndex;

  MenuCategories({
    required this.onChanged,
    required this.selectedIndex,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: heightCategories,
      padding: const EdgeInsets.only(
        bottom: 10,
        top: 10,
      ),
      color: AppColors.white,
      child: Categories(
        onChanged: onChanged,
        selectedIndex: selectedIndex,
      ),
    );
  }

  @override
  double get maxExtent => heightCategories;

  @override
  double get minExtent => heightCategories;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class Categories extends StatefulWidget {
  const Categories({
    super.key,
    required this.onChanged,
    required this.selectedIndex,
  });

  final ValueChanged<int> onChanged;
  final int selectedIndex;

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late ScrollController controller;
  final double paddingHorizontal = 24;

  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Categories oldWidget) {
    final anchoPantalla = MediaQuery.of(context).size.width;

    double scrollRestante =
        48 + (menu.length - widget.selectedIndex) * widthSeparateCategories;

    for (var i = widget.selectedIndex; i < menu.length; i++) {
      if (_keys[i].currentContext == null) return;
      final RenderBox renderBox =
          _keys[i].currentContext!.findRenderObject() as RenderBox;
      scrollRestante += renderBox.size.width;
    }

    if (scrollRestante < anchoPantalla) return;

    double scrollDistance = 0;

    for (var i = 0; i < widget.selectedIndex; i++) {
      if (_keys[i].currentContext == null) return;
      final RenderBox renderBox =
          _keys[i].currentContext!.findRenderObject() as RenderBox;
      scrollDistance += renderBox.size.width;
      scrollDistance += widthSeparateCategories;
    }

    controller.animateTo(
      scrollDistance,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final List<GlobalKey<State>> _keys =
      List.generate(menu.length, (_) => GlobalKey());

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      controller: controller,
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
      ),
      itemBuilder: (context, index) {
        final key = _keys[index];
        final bool isSelected = widget.selectedIndex == index;

        return SizedBox(
          child: TextButton(
            key: key,
            onPressed: () {
              widget.onChanged(index);
            },
            style: TextButton.styleFrom(
              foregroundColor: isSelected ? AppColors.white : Colors.black38,
              side: const BorderSide(color: AppColors.gray300),
              padding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 18,
              ),
              backgroundColor:
                  isSelected ? AppColors.primary : Colors.transparent,
            ),
            child: Text(
              menu[index].name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.white : AppColors.label,
                height: 1.3,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: widthSeparateCategories,
        );
      },
      itemCount: menu.length,
    );
  }
}
