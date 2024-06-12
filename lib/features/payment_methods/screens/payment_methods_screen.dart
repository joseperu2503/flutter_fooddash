import 'package:fooddash/features/payment_methods/data/cards.dart';
import 'package:fooddash/features/payment_methods/widgets/card_item.dart';
import 'package:fooddash/features/payment_methods/widgets/cash_item.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(
                right: 24,
                left: 24,
                top: 40,
                bottom: 16,
              ),
              child: const CashItem(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            sliver: SliverList.separated(
              itemBuilder: (context, index) {
                final card = cards[index];
                return CardItem(
                  onPress: () {},
                  card: card,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 16,
                );
              },
              itemCount: cards.length,
            ),
          ),
        ],
      ),
    );
  }
}
