import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/features/payment_methods/data/cards.dart';
import 'package:delivery_app/features/shared/widgets/check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 36,
                ),
                Text(
                  'Payment method',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.label2,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                Divider(
                  color: AppColors.gray100,
                  height: 40,
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
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xffD3D1D8).withOpacity(0.45),
                            offset: const Offset(6, 8),
                            blurRadius: 22.96,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      height: 80,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/cash.svg',
                              height: 40,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            const Text(
                              'Cash',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.gray800,
                                height: 16 / 16,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                            const Spacer(),
                            const Check(
                              isSelected: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  sliver: SliverList.separated(
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xffD3D1D8).withOpacity(0.45),
                              offset: const Offset(6, 8),
                              blurRadius: 22.96,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        height: 80,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                            ),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/visa.svg',
                                height: 60,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Debit card',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.gray900,
                                        height: 1,
                                        leadingDistribution:
                                            TextLeadingDistribution.even,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      '4929 **** **** 1976',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.gray600,
                                        height: 1,
                                        leadingDistribution:
                                            TextLeadingDistribution.even,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Check(
                                isSelected: false,
                              ),
                            ],
                          ),
                        ),
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
