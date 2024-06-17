import 'package:fooddash/config/api/api.dart';
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
}
