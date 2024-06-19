import 'package:fooddash/config/api/api.dart';
import 'package:fooddash/features/cart/models/cart_request.dart';
import 'package:fooddash/features/cart/models/cart_response.dart';

class CartService {
  static Future<CartResponse?> getMyCart() async {
    try {
      final response = await Api().get('/carts/my-cart');

      return response.data != '' ? CartResponse.fromJson(response.data) : null;
    } catch (e) {
      throw 'An error occurred while loading the cart.';
    }
  }

  static Future<CartResponse> updateMyCart(CartRequest cartRequest) async {
    try {
      final Map<String, dynamic> data = cartRequest.toJson();

      final response = await Api().post('/carts', data: data);

      return CartResponse.fromJson(response.data);
    } catch (e) {
      throw 'An error occurred while loading the cart.';
    }
  }

  static Future<void> deleteMyCart() async {
    try {
      await Api().delete('/carts/my-cart');
    } catch (e) {
      throw 'An error occurred while deleting the cart.';
    }
  }
}
