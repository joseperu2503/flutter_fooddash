import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/features/cart/providers/cart_provider.dart';
import 'package:fooddash/app/features/cart/widgets/cart_bottom_sheet_1.dart';
import 'package:fooddash/app/features/cart/widgets/cart_dish_item.dart';
import 'package:fooddash/app/features/shared/widgets/back_button.dart';
import 'package:fooddash/app/features/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const double heightBottomSheet = 380;

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends ConsumerState<CartScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(cartProvider.notifier).getCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProvider);

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
      body: (cartState.cartResponse != null)
          ? CustomScrollView(
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
                    bottom: 36,
                  ),
                  sliver: SliverList.separated(
                    itemBuilder: (context, index) {
                      final dish = cartState.cartResponse!.dishCarts[index];

                      return CartDishItem(
                        dishCart: dish,
                        index: index,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 32,
                      );
                    },
                    itemCount: cartState.cartResponse!.dishCarts.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const Divider(
                          color: AppColors.slate100,
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                ref.read(cartProvider.notifier).emptyCart();
                              },
                              behavior: HitTestBehavior.translucent,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 18,
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Empty cart',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.error,
                                    height: 1,
                                    leadingDistribution:
                                        TextLeadingDistribution.even,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          : SafeArea(
              child: CustomScrollView(
                // physics: ClampingScrollPhysics(),
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        const Spacer(),
                        SvgPicture.asset(
                          'assets/icons/cart_outlined.svg',
                          width: 100,
                          colorFilter: const ColorFilter.mode(
                            AppColors.slate700,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          'your cart is empty',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppColors.slate900,
                            height: 32 / 24,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          'Seems like you have not ordered\nany food yet',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.slate600,
                            height: 22 / 14,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: CustomButton(
                            text: 'Find Foods',
                            onPressed: () {
                              context.go('/dashboard');
                            },
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  )
                ],
              ),
            ),
      bottomSheet:
          (cartState.cartResponse != null) ? const CartBottomSheet1() : null,
    );
  }
}

class BottomModal3 extends StatelessWidget {
  const BottomModal3({super.key});

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
                                  boxShadowType: BoxShadowType.none,
                                ),
                              ),
                            ),
                            cursorHeight: 16,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.slate900,
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
                                color: AppColors.slate800,
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
                                color: AppColors.slate800,
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
                                color: AppColors.slate800,
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
                                    color: AppColors.slate500,
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
                                    color: AppColors.slate800,
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
