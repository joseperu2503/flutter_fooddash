import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/features/cart/widgets/cart_dish_item.dart';
import 'package:delivery_app/features/restaurant/data/menu.dart';
import 'package:delivery_app/features/shared/widgets/back_button.dart';
import 'package:delivery_app/features/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const double heightBottomSheet = 380;

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dishes = menu[0].dishes;
    return Scaffold(
      appBar: AppBar(
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
                  'My Cart',
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
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 40,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  bottom: heightBottomSheet,
                ),
                sliver: SliverList.separated(
                  itemBuilder: (context, index) {
                    final dish = dishes[index];

                    return CartDishItem(dish: dish);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 32,
                    );
                  },
                  itemCount: 2,
                ),
              ),
            ],
          ),
          const BottomModal(),
        ],
      ),
    );
  }
}

class BottomModal extends StatelessWidget {
  const BottomModal({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData screen = MediaQuery.of(context);

    final double heigh =
        (heightBottomSheet + screen.padding.bottom) / screen.size.height;
    return DraggableScrollableSheet(
      initialChildSize: heigh,
      minChildSize: heigh,
      maxChildSize: heigh,
      snap: true,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(42),
              topRight: Radius.circular(42),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(63, 76, 95, 0.12),
                offset: Offset(0, -4),
                blurRadius: 20,
                spreadRadius: 0,
              ),
            ],
          ),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 28,
                        ),
                        SizedBox(
                          height: 60,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.inputBorder,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.primary,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              hintText: 'Promo Code',
                              hintStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffBEBEBE),
                                height: 1,
                              ),
                              prefix: const SizedBox(width: 10),
                              suffixIcon: Container(
                                padding: const EdgeInsets.only(right: 8),
                                child: CustomButton(
                                  width: 96,
                                  height: 44,
                                  onPressed: () {},
                                  text: 'Apply',
                                  boxShadow: BoxShadowType.none,
                                ),
                              ),
                            ),
                            cursorHeight: 16,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.gray900,
                              height: 1,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Subtotal',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                                height: 1,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '\$27.30',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                                color: AppColors.gray800,
                                height: 1,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Color(0xffF1F2F3),
                          height: 32,
                        ),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Tax and Fees',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                                height: 1,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '\$5.30',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                                color: AppColors.gray800,
                                height: 1,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Color(0xffF1F2F3),
                          height: 32,
                        ),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Delivery',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                                height: 1,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '\$1.00',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                                color: AppColors.gray800,
                                height: 1,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.label,
                                    height: 1.5,
                                    leadingDistribution:
                                        TextLeadingDistribution.even,
                                  ),
                                ),
                                Text(
                                  '\$131.99',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.gray800,
                                    height: 1.5,
                                    leadingDistribution:
                                        TextLeadingDistribution.even,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            const Spacer(),
                            CustomButton(
                              onPressed: () {
                                context.push('/checkout');
                              },
                              text: 'CHECKOUT',
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
