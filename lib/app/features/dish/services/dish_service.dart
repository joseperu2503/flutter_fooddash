import 'package:fooddash/app/config/api/api.dart';
import 'package:fooddash/app/features/dish/models/dish.dart';
import 'package:fooddash/app/features/dish/models/topping_category.dart';

class DishService {
  static Future<Dish> getDish({
    required String dishId,
  }) async {
    try {
      final response = await Api().get('/dishes/$dishId');

      return Dish.fromJson(response.data);
    } catch (e) {
      throw 'An error occurred while loading the dish.';
    }
  }

  static Future<List<ToppingCategory>> getToppings({
    required String dishId,
  }) async {
    try {
      final response = await Api().get('/dishes/$dishId/toppings');

      return List<ToppingCategory>.from(
          response.data.map((x) => ToppingCategory.fromJson(x)));
    } catch (e) {
      throw 'An error occurred while loading the toppings.';
    }
  }
}
