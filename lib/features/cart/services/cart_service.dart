import 'package:fooddash/config/api/api.dart';
import 'package:fooddash/features/cart/models/cart_request.dart';
import 'package:fooddash/features/cart/models/cart_response.dart';

class CartService {
  static Future<CartResponse> getMyCart() async {
    try {
      final response = await Api().get('/carts/my-cart');

      return CartResponse.fromJson(response.data);
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
}
