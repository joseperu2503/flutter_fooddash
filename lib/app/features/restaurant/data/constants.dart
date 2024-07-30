import 'package:flutter/material.dart';
import 'package:fooddash/app/config/constants/styles.dart';

const double widthSeparateCategories = 10;
// const double heightRestaurantInfo = 220;
const double collapsedHeightAppbar = 60;
const double expandedHeightAppbarRestaurant = 200;
const double heightEnd = 30;

const double heightCategories = 58;
const double heightCategoryTitle = 30;
const double heightCategoryTitleSpace = 10;
const double heightCategorySpace = 18;

//Dish
// const double heightDish = 250;
const double heightDishInfo = 90;

//grid dishes
int crossAxisCount = 2;
double crossAxisSpacing = 16;
double mainAxisSpacing = 16;

double widthGridDish(double width) {
  return (width - horizontalPaddingMobile * 2 - crossAxisSpacing) /
      crossAxisCount;
}

double heightGridDish(double width) {
  return widthGridDish(width) + heightDishInfo;
}

SliverGridDelegateWithFixedCrossAxisCount dishSliverGridDelegate(
  double width,
) {
  return SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: crossAxisCount,
    mainAxisSpacing: mainAxisSpacing,
    crossAxisSpacing: crossAxisSpacing,
    childAspectRatio: widthGridDish(width) / heightGridDish(width),
  );
}
