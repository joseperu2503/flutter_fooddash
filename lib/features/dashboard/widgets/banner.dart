import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BannerDashboard extends StatefulWidget {
  const BannerDashboard({super.key});

  @override
  State<BannerDashboard> createState() => _BannerDashboardState();
}

class _BannerDashboardState extends State<BannerDashboard> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        margin: const EdgeInsets.only(
          top: 16,
        ),
        height: 142,
        child: Container(
          height: 142,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primary400,
            gradient: const LinearGradient(colors: [
              AppColors.primary500,
              AppColors.primary500,
              AppColors.primary200,
            ], stops: [
              0,
              0.2,
              1
            ]),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Claim your\ndiscount 30%\ndaily now!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                        height: 19 / 16,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                    const Spacer(),
                    FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        backgroundColor: AppColors.gray900,
                      ),
                      child: const Text(
                        'Order now',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                          height: 14.4 / 12,
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      right: 24,
                      top: -30,
                      child: Transform.flip(
                        flipX: true,
                        child: Image.asset(
                          'assets/images_prueba/icecream.png',
                          height: 225,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
