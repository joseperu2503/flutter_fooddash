import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/features/restaurant/data/constants.dart';
import 'package:delivery_app/features/restaurant/models/restaurant_detail.dart';
import 'package:flutter/material.dart';

class DishCategories extends StatefulWidget {
  const DishCategories({
    super.key,
    required this.onChanged,
    required this.selectedIndex,
    required this.menu,
  });

  final ValueChanged<int> onChanged;
  final int selectedIndex;
  final List<DishCategory> menu;

  @override
  State<DishCategories> createState() => _DishCategoriesState();
}

class _DishCategoriesState extends State<DishCategories> {
  late ScrollController _scrollController = ScrollController();
  final double paddingHorizontal = 24;
  List<GlobalKey<State>> _keys = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(DishCategories oldWidget) {
    if (widget.menu.length != oldWidget.menu.length) {
      _generateKeys();
    }

    if (widget.selectedIndex != oldWidget.selectedIndex) {
      final anchoPantalla = MediaQuery.of(context).size.width;

      double scrollRestante = 48;

      for (var i = widget.selectedIndex; i < widget.menu.length; i++) {
        if (_keys[i].currentContext == null) return;
        final RenderBox renderBox =
            _keys[i].currentContext!.findRenderObject() as RenderBox;
        scrollRestante += widthSeparateCategories;
        scrollRestante += renderBox.size.width;
      }
      double scrollDistance = 0;

      if (scrollRestante < anchoPantalla) {
        scrollDistance = _scrollController.position.maxScrollExtent;
      } else {
        for (var i = 0; i < widget.selectedIndex; i++) {
          if (_keys[i].currentContext == null) return;
          final RenderBox renderBox =
              _keys[i].currentContext!.findRenderObject() as RenderBox;
          scrollDistance += renderBox.size.width;
          scrollDistance += widthSeparateCategories;
        }
      }

      _scrollController.animateTo(
        scrollDistance,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }

    super.didUpdateWidget(oldWidget);
  }

  _generateKeys() {
    _keys = List.generate(widget.menu.length, (_) => GlobalKey());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightCategories,
      padding: const EdgeInsets.only(
        bottom: 10,
        top: 10,
      ),
      color: AppColors.white,
      child: (widget.menu.isNotEmpty)
          ? ListView.separated(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
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
                      foregroundColor:
                          isSelected ? AppColors.white : Colors.black38,
                      side: const BorderSide(color: AppColors.gray300),
                      padding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 18,
                      ),
                      backgroundColor:
                          isSelected ? AppColors.primary : Colors.transparent,
                    ),
                    child: Text(
                      widget.menu[index].name,
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
              itemCount: widget.menu.length,
            )
          : null,
    );
  }
}
