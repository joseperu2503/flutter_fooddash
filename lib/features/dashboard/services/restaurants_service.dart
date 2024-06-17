import 'package:fooddash/config/api/api.dart';
import 'package:fooddash/features/dashboard/models/category.dart';
import 'package:fooddash/features/dashboard/models/restaurant.dart';

class RestaurantsService {
  static Future<List<Restaurant>> getRestaurants() async {
    try {
      final response = await Api().get('/restaurants');

      return List<Restaurant>.from(
          response.data.map((x) => Restaurant.fromJson(x)));
    } catch (e) {
      throw 'An error occurred while loading the restaurants.';
    }
  }

  static Future<List<Category>> getCategories() async {
    try {
      final response = await Api().get('/categories');

      return List<Category>.from(
          response.data.map((x) => Category.fromJson(x)));
    } catch (e) {
      throw 'An error occurred while loading the categories.';
    }
  }
}
