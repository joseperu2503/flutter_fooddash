import 'package:flutter_fooddash/config/constants/app_colors.dart';
import 'package:flutter_fooddash/features/dashboard/models/category.dart';
import 'package:flutter/material.dart';

class CategoriesDashboard extends StatelessWidget {
  const CategoriesDashboard({
    super.key,
    required this.categories,
  });

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 10,
              left: 24,
              right: 24,
            ),
            child: const Text(
              'Top Categories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.label2,
                height: 1,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            height: 120,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final category = categories[index];
                return CategoryItem(
                  category: category,
                  isSelected: index == 2,
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
  });

  final Category category;
  final bool isSelected;

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
            onPressed: () {},
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
            color: isSelected ? AppColors.primary : AppColors.gray800,
            height: 1,
            leadingDistribution: TextLeadingDistribution.even,
          ),
        ),
      ],
    );
  }
}
