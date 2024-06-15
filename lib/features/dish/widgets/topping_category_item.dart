import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import 'package:fooddash/config/constants/app_colors.dart';
import 'package:fooddash/features/dish/models/dish_detail.dart';
import 'package:fooddash/features/dish/providers/dish_provider.dart';
import 'package:fooddash/features/shared/widgets/button_stepper.dart';
import 'package:fooddash/features/shared/widgets/custom_check.dart';

class ToppingCategoryItem extends StatefulWidget {
  const ToppingCategoryItem({
    super.key,
    required this.toppingCategory,
    required this.onPressTopping,
    required this.selectedToppings,
  });

  final ToppingCategory toppingCategory;
  final void Function(Topping topping, int quantity) onPressTopping;
  final List<SelectedTopping> selectedToppings;

  @override
  State<ToppingCategoryItem> createState() => _TermDesplegableState();
}

class _TermDesplegableState extends State<ToppingCategoryItem> {
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
    int numSelectedToppings = 0;

    for (SelectedTopping selectedTopping in widget.selectedToppings) {
      if (selectedTopping.toppingCategoryId == widget.toppingCategory.id) {
        numSelectedToppings = numSelectedToppings + selectedTopping.quantity;
      }
    }

    final bool isMandatory = widget.toppingCategory.minToppings > 0;
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.toppingCategory.description,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.label2,
                        height: 1.3,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                    if (widget.toppingCategory.subtitle.isNotEmpty)
                      Text(
                        widget.toppingCategory.subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.gray700,
                          height: 1,
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              if (isMandatory)
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
                  width: 14,
                  height: 14,
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
                      final int selectedToppingIndex = widget.selectedToppings
                          .indexWhere((selectedTopping) =>
                              selectedTopping.toppingId == topping.id);

                      final bool isSelectedTopping = selectedToppingIndex >= 0;
                      final int quantity = isSelectedTopping
                          ? widget
                              .selectedToppings[selectedToppingIndex].quantity
                          : 0;

                      return Container(
                        height: 60,
                        padding: const EdgeInsets.only(
                          left: 24,
                          right: 14,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    topping.description,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.label2,
                                      height: 1.5,
                                      leadingDistribution:
                                          TextLeadingDistribution.even,
                                    ),
                                  ),
                                  Text(
                                    '+ \$${topping.price}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black,
                                      height: 1,
                                      leadingDistribution:
                                          TextLeadingDistribution.even,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            if (topping.maxLimit == 1)
                              CustomCheck(
                                isSelected: isSelectedTopping,
                                onChange: (isSelected) {
                                  if (!isSelectedTopping) {
                                    setState(() {
                                      isExpanded = false;
                                    });
                                  }
                                  widget.onPressTopping(
                                      topping, isSelectedTopping ? 0 : 1);
                                },
                                type: (widget.toppingCategory.maxToppings == 1)
                                    ? CheckType.single
                                    : CheckType.multiple,
                              ),
                            if (topping.maxLimit > 1)
                              Container(
                                padding: const EdgeInsets.only(right: 6),
                                child: ButtonStepper(
                                  value: quantity,
                                  onAdd: quantity == topping.maxLimit ||
                                          numSelectedToppings ==
                                              widget.toppingCategory.maxToppings
                                      ? null
                                      : () {
                                          widget.onPressTopping(
                                              topping, quantity + 1);
                                        },
                                  onRemove: quantity == 0
                                      ? null
                                      : () {
                                          widget.onPressTopping(
                                              topping, quantity - 1);
                                        },
                                ),
                              )
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
