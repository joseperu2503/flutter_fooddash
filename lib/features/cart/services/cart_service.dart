import 'package:fooddash/config/api/api.dart';
import 'package:fooddash/features/cart/models/cart_request.dart';
import 'package:fooddash/features/cart/models/cart_response.dart';
import 'package:fooddash/features/core/models/service_exception.dart';

class CartService {
  static Future<CartResponse?> getMyCart() async {
    try {
      final response = await Api().get('/carts/my-cart');

      return response.data != '' ? CartResponse.fromJson(response.data) : null;
    } catch (e) {
      throw ServiceException('An error occurred while loading the cart.', e);
    }
  }

  static Future<CartResponse?> updateMyCart(CartRequest cartRequest) async {
    try {
      final Map<String, dynamic> data = cartRequest.toJson();

      final response = await Api().post('/carts', data: data);

      return response.data != '' ? CartResponse.fromJson(response.data) : null;
    } catch (e) {
      throw ServiceException('An error occurred while loading the cart.', e);
    }
  }

  static Future<void> deleteMyCart() async {
    try {
      await Api().delete('/carts/my-cart');
    } catch (e) {
      throw ServiceException('An error occurred while deleting the cart.', e);
    }
  }
}
