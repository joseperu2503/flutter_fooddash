import 'package:fooddash/app/config/api/api.dart';
import 'package:fooddash/app/features/core/models/service_exception.dart';
import 'package:fooddash/app/features/dashboard/models/restaurant_category.dart';
import 'package:fooddash/app/features/dashboard/models/restaurant.dart';
import 'package:fooddash/app/features/restaurant/models/dish_category.dart';
import 'package:fooddash/app/features/restaurant/models/restaurant.dart';

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
          await Api.get('/restaurants', queryParameters: queryParameters);

      return RestaurantsResponse.fromJson(response.data);
    } catch (e) {
      throw ServiceException(
          'An error occurred while loading the restaurants.', e);
    }
  }

  static Future<List<RestaurantCategory>> getCategories() async {
    try {
      final response = await Api.get('/restaurants/categories');

      return List<RestaurantCategory>.from(
          response.data.map((x) => RestaurantCategory.fromJson(x)));
    } catch (e) {
      throw ServiceException(
          'An error occurred while loading the categories.', e);
    }
  }

  static Future<Restaurant> getRestaurant({
    required int restaurantId,
  }) async {
    try {
      final response = await Api.get('/restaurants/$restaurantId');

      return Restaurant.fromJson(response.data);
    } catch (e) {
      throw ServiceException(
          'An error occurred while loading the restaurant.', e);
    }
  }

  static Future<List<DishCategory>> getDishes({
    required int restaurantId,
  }) async {
    try {
      final response = await Api.get('/restaurants/$restaurantId/dishes');

      return List<DishCategory>.from(
          response.data.map((x) => DishCategory.fromJson(x)));
    } catch (e) {
      throw ServiceException('An error occurred while loading the dishes.', e);
    }
  }

  static Future<Restaurant> toggleFavorite({
    required int restaurantId,
  }) async {
    try {
      Map<String, dynamic> form = {
        "restaurantId": restaurantId,
      };

      final response = await Api.post(
        '/favorites/restaurant',
        data: form,
      );

      return Restaurant.fromJson(response.data);
    } catch (e) {
      throw ServiceException('An error occurred.', e);
    }
  }

  static Future<RestaurantsResponse> getFavorites({
    int page = 1,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {
        "page": page,
        "limit": 5,
      };
      final response = await Api.get(
        '/favorites/restaurant',
        queryParameters: queryParameters,
      );

      return RestaurantsResponse.fromJson(response.data);
    } catch (e) {
      throw ServiceException(
          'An error occurred while loading the favorite restaurants.', e);
    }
  }
}
