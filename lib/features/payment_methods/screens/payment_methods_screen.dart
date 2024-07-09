import 'package:fooddash/features/payment_methods/providers/payment_method_provider.dart';
import 'package:fooddash/features/payment_methods/widgets/payment_method_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/config/constants/app_colors.dart';
import 'package:fooddash/features/shared/widgets/back_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

const double heightBottomSheet = 380;

class PaymentMethodsScreen extends ConsumerStatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  CardFormScreenState createState() => CardFormScreenState();
}

class CardFormScreenState extends ConsumerState<PaymentMethodsScreen> {
  bool showBackView = false;
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

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            height: 60,
            child: Row(
              children: [
                const CustomBackButton(),
                const Spacer(),
                const Text(
                  'Payment Methods',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.input,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                const Spacer(),
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
                  height: 38,
                  width: 38,
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
          ),
        ),
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(
              right: 24,
              left: 24,
              top: 40,
              bottom: 16,
            ),
            sliver: SliverList.separated(
              itemBuilder: (context, index) {
                final card = paymentState.paymentMethods[index];
                return PaymentMethodItem(
                  onPress: card.id == 'cash'
                      ? null
                      : () {
                          context
                              .push('/payment-methods/card-detail/${card.id}');
                        },
                  paymentMethod: card,
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
    );
  }
}
