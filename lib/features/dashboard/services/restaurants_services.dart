import 'package:delivery_app/config/api/api.dart';
import 'package:delivery_app/features/dashboard/models/restaurant.dart';

class RestaurantsService {
  static Future<List<Restaurant>> getRestaurants() async {
    try {
      final response = await Api.get('/restaurants');

      return List<Restaurant>.from(
          response.data.map((x) => Restaurant.fromJson(x)));
    } catch (e) {
      throw 'An error occurred while loading the products.';
    }
  }
}
