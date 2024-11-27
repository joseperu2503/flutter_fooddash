import 'package:fooddash/app/config/api/api.dart';
import 'package:fooddash/app/features/cart/models/cart_request.dart';
import 'package:fooddash/app/features/cart/models/cart_response.dart';
import 'package:fooddash/app/features/core/models/service_exception.dart';

class CartService {
  static Future<CartResponse?> getCart() async {
    try {
      final response = await Api.get('/cart');

      return response.data != '' ? CartResponse.fromJson(response.data) : null;
    } catch (e) {
      throw ServiceException('An error occurred while loading the cart.', e);
    }
  }

  static Future<CartResponse?> updateCart(CartRequest cartRequest) async {
    try {
      final Map<String, dynamic> data = cartRequest.toJson();

      final response = await Api.post('/cart', data: data);

      return response.data != '' ? CartResponse.fromJson(response.data) : null;
    } catch (e) {
      throw ServiceException('An error occurred while updating the cart.', e);
    }
  }

  static Future<void> emptyCart() async {
    try {
      await Api.delete('/cart');
    } catch (e) {
      throw ServiceException('An error occurred while deleting the cart.', e);
    }
  }
}
