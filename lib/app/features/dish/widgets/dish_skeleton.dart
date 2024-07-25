import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:flutter/material.dart';

class DishSkeleton extends StatelessWidget {
  const DishSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth;

        return Column(
          children: [
            AnimatedShimmer(
              height: width,
              width: width,
              borderRadius: BorderRadius.circular(12),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: AnimatedShimmer(
                height: 14,
                width: width,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: AnimatedShimmer(
                height: 12,
                width: width,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ],
        );
      },
    );
  }
}
