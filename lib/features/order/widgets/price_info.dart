import 'package:fooddash/config/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PriceInfo extends StatefulWidget {
  const PriceInfo({super.key});

  @override
  State<PriceInfo> createState() => _PriceInfoState();
}

class _PriceInfoState extends State<PriceInfo> {
  bool _isExpanded = false;

  void _toggleHeight() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xffD3D1D8).withOpacity(0.3),
            offset: const Offset(8, 12),
            blurRadius: 22.96,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
          height: _isExpanded ? 240 : 60,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: TextButton(
                  onPressed: () {
                    _toggleHeight();
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 240,
                    width: MediaQuery.of(context).size.width - 48,
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 60,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                  height: 1,
                                  leadingDistribution:
                                      TextLeadingDistribution.even,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '\$25.30',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.gray800,
                                  height: 1,
                                  leadingDistribution:
                                      TextLeadingDistribution.even,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Color(0xffF1F2F3),
                          height: 32,
                        ),
                        Row(
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
                        Divider(
                          color: Color(0xffF1F2F3),
                          height: 32,
                        ),
                        Row(
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
                        Divider(
                          color: Color(0xffF1F2F3),
                          height: 32,
                        ),
                        Row(
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
