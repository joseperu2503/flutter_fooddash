import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/features/dashboard/models/category.dart';
import 'package:flutter/material.dart';
import 'package:fooddash/app/features/dashboard/providers/restaurants_provider.dart';
import 'package:fooddash/app/features/shared/models/loading_status.dart';

class CategoriesDashboard extends ConsumerWidget {
  const CategoriesDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantsState = ref.watch(restaurantsProvider);
    final categories = restaurantsState.categories;
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   padding: const EdgeInsets.only(
          //     top: 10,
          //     left: 24,
          //     right: 24,
          //   ),
          //   child: const Text(
          //     'Top Categories',
          //     style: TextStyle(
          //       fontSize: 20,
          //       fontWeight: FontWeight.w700,
          //       color: AppColors.slate900,
          //       height: 1,
          //       leadingDistribution: TextLeadingDistribution.even,
          //     ),
          //   ),
          // ),
          const SizedBox(
            height: 12,
          ),
          if (restaurantsState.categoriesStatus == LoadingStatus.success)
            SizedBox(
              height: 120,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryItem(
                    category: category,
                    isSelected: category.id == restaurantsState.category?.id,
                    onPress: (category) {
                      ref
                          .read(restaurantsProvider.notifier)
                          .setCategory(category);
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 16,
                  );
                },
                itemCount: categories.length,
              ),
            ),

          if (restaurantsState.categoriesStatus == LoadingStatus.loading)
            SizedBox(
              height: 120,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      AnimatedShimmer(
                        height: 88,
                        width: 88,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      AnimatedShimmer(
                        height: 12,
                        width: 65,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 16,
                  );
                },
                itemCount: 5,
              ),
            ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onPress,
  });

  final Category category;
  final bool isSelected;
  final void Function(Category category) onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: isSelected
                ? AppColors.primary.withOpacity(0.1)
                : AppColors.white,
            border: Border.all(
              color: isSelected ? AppColors.primary : const Color(0xffEFEFEF),
            ),
          ),
          child: TextButton(
            onPressed: () {
              onPress(category);
            },
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 42,
                height: 42,
                child: Image.network(
                  category.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          category.name,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColors.primary : AppColors.slate800,
            height: 1,
            leadingDistribution: TextLeadingDistribution.even,
          ),
        ),
      ],
    );
  }
}
