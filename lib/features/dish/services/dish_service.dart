import 'package:flutter_fooddash/config/api/api.dart';
import 'package:flutter_fooddash/features/dish/models/dish_detail.dart';

class DishService {
  static Future<DishDetail> getDish({
    required String dishId,
  }) async {
    try {
      final response = await Api.get('/dishes/$dishId');

      return DishDetail.fromJson(response.data);
    } catch (e) {
      throw 'An error occurred while loading the dish.';
    }
  }
}
