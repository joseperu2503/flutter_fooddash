import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

import 'package:fooddash/config/constants/app_colors.dart';
import 'package:fooddash/features/dish/models/dish_detail.dart';
import 'package:fooddash/features/shared/widgets/custom_check.dart';

class ToppingCategoryItem extends ConsumerStatefulWidget {
  const ToppingCategoryItem({
    super.key,
    required this.toppingCategory,
  });

  final ToppingCategory toppingCategory;

  @override
  TermDesplegableState createState() => TermDesplegableState();
}

class TermDesplegableState extends ConsumerState<ToppingCategoryItem> {
  bool isExpanded = true;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  double get heightContent {
    if (_key.currentContext != null) {
      final RenderBox renderBox =
          _key.currentContext!.findRenderObject() as RenderBox;
      return renderBox.size.height;
    }

    return 60.0 * widget.toppingCategory.toppings.length;
  }

  @override
  Widget build(BuildContext context) {
    final toppings = widget.toppingCategory.toppings;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          style: TextButton.styleFrom(
            shape: const ContinuousRectangleBorder(),
            padding: const EdgeInsets.only(
              right: 24,
              left: 24,
              bottom: 24,
              top: 24,
            ),
            minimumSize: const Size(0, 70),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.toppingCategory.description,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.label2,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              if (widget.toppingCategory.minToppings > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.inputHint,
                    ),
                    borderRadius: BorderRadiusDirectional.circular(8),
                  ),
                  child: const Text(
                    'Mandatory',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.label2,
                      height: 12 / 12,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                ),
              const SizedBox(
                width: 12,
              ),
              Transform.rotate(
                angle: isExpanded ? math.pi : 0,
                child: SvgPicture.asset(
                  'assets/icons/arrow_down.svg',
                  width: 12,
                  height: 12,
                  colorFilter: const ColorFilter.mode(
                    AppColors.input,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: isExpanded ? heightContent : 0,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  key: _key,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColors.inputBorder,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final topping = toppings[index];
                      return Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),
                        child: Row(
                          children: [
                            Text(
                              topping.description,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.label2,
                                height: 16 / 16,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '+\$${topping.price}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                                height: 1,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            CustomCheck(
                              isSelected: index == 1,
                              onChange: (isSelected) {},
                              type: (widget.toppingCategory.maxToppings == 1)
                                  ? CheckType.single
                                  : CheckType.multiple,
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: toppings.length,
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
