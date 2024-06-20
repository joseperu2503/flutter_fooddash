import 'package:fooddash/config/constants/app_colors.dart';
import 'package:fooddash/features/payment_methods/data/cards.dart';
import 'package:fooddash/features/payment_methods/widgets/card_item.dart';
import 'package:fooddash/features/payment_methods/widgets/cash_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class PaymentModal extends StatelessWidget {
  const PaymentModal({super.key});

  @override
  Widget build(BuildContext context) {
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
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Payment method',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.label2,
                          height: 1,
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
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
                  height: 34,
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.only(
                      right: 24,
                      left: 24,
                      bottom: 16,
                    ),
                    child: CashItem(
                      isSelected: true,
                      onPress: () {},
                    ),
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
                        isSelected: false,
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
          )
        ],
      ),
    );
  }
}
