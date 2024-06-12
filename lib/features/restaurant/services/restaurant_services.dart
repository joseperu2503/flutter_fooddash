import 'package:flutter_fooddash/config/api/api.dart';
import 'package:flutter_fooddash/features/restaurant/models/restaurant_detail.dart';

class RestaurantService {
  static Future<RestaurantDetail> getRestaurant({
    required String restaurantId,
  }) async {
    try {
      final response = await Api.get('/restaurants/$restaurantId');

      return RestaurantDetail.fromJson(response.data);
    } catch (e) {
      throw 'An error occurred while loading the restaurant detail.';
    }
  }
}
