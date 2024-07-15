import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/config/constants/styles.dart';
import 'package:fooddash/app/features/payment_methods/providers/payment_method_provider.dart';
import 'package:fooddash/app/features/payment_methods/widgets/payment_method_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/app/features/shared/widgets/custom_drag_handle.dart';
import 'package:go_router/go_router.dart';

class PaymentModal extends ConsumerStatefulWidget {
  const PaymentModal({super.key});

  @override
  PaymentModalState createState() => PaymentModalState();
}

class PaymentModalState extends ConsumerState<PaymentModal> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(paymentMethodProvider.notifier).getMyPaymentMethods();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paymentState = ref.watch(paymentMethodProvider);

    return SizedBox(
      height: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CustomDragHandle(),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Payment method',
                        style: modalBottomSheetTitle,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary,
                        ),
                        color: AppColors.primary,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.orange.withOpacity(0.4),
                            offset: const Offset(0, 7),
                            blurRadius: 15,
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      height: 36,
                      width: 36,
                      child: TextButton(
                        onPressed: () {
                          context.push('/card-form');
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/plus.svg',
                          height: 28,
                          colorFilter: const ColorFilter.mode(
                            AppColors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: AppColors.slate100,
                  height: 30,
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  sliver: SliverList.separated(
                    itemBuilder: (context, index) {
                      final card = paymentState.paymentMethods[index];
                      return PaymentMethodItem(
                        onPress: () {},
                        paymentMethod: card,
                        isSelected: false,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 16,
                      );
                    },
                    itemCount: paymentState.paymentMethods.length,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
