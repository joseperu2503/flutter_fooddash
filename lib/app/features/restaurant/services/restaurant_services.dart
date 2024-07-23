import 'package:fooddash/app/config/api/api.dart';
import 'package:fooddash/app/features/restaurant/models/restaurant.dart';

class RestaurantService {
  static Future<Restaurant> getRestaurant({
    required String restaurantId,
  }) async {
    try {
      final response = await Api().get('/restaurants/$restaurantId');

      return Restaurant.fromJson(response.data);
    } catch (e) {
      throw 'An error occurred while loading the restaurant detail.';
    }
  }
}
