import 'dart:math';

import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantSkeleton extends ConsumerWidget {
  const RestaurantSkeleton({
    super.key,
    this.showLogo = true,
    this.height = 240,
    this.width = double.infinity,
  });

  final bool showLogo;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(211, 209, 216, 0.25),
            offset: Offset(15, 15),
            blurRadius: 30,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: AnimatedShimmer(
                height: width,
                width: width,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 13,
                vertical: 14,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (showLogo)
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: AnimatedShimmer.round(
                        size: 48,
                      ),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedShimmer(
                          height: 15,
                          width: 80.0 + Random().nextInt(41),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 16,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 1),
                                child: AnimatedShimmer(
                                  height: 12,
                                  width: 60,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 1),
                                child: AnimatedShimmer(
                                  height: 12,
                                  width: 60,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
