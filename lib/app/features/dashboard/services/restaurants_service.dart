import 'package:fooddash/app/config/api/api.dart';
import 'package:fooddash/app/features/dashboard/models/category.dart';
import 'package:fooddash/app/features/dashboard/models/restaurant.dart';

class RestaurantsService {
  static Future<RestaurantsResponse> getRestaurants({
    int page = 1,
    int? restaurantCategoryId,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {
        "page": page,
        "limit": 5,
        "restaurantCategoryId": restaurantCategoryId,
      };
      final response =
          await Api().get('/restaurants', queryParameters: queryParameters);

      return RestaurantsResponse.fromJson(response.data);
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
