import 'package:fooddash/app/config/api/api.dart';
import 'package:fooddash/app/features/auth/models/login_response.dart';
import 'package:fooddash/app/features/core/models/service_exception.dart';

class FavoritesService {
  static Future<LoginResponse> restaurant({
    required String restaurantId,
  }) async {
    try {
      Map<String, dynamic> form = {
        "restaurantId": restaurantId,
      };

      final response = await Api().post('/favorites/restaurant', data: form);

      return LoginResponse.fromJson(response.data);
    } catch (e) {
      throw ServiceException('An error occurred.', e);
    }
  }
}
