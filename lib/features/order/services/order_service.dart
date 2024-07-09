import 'package:fooddash/config/api/api.dart';
import 'package:fooddash/features/core/models/service_exception.dart';
import 'package:fooddash/features/order/models/order.dart';

final api = Api();

class OrderService {
  static Future<List<Order>> getMyOrders() async {
    try {
      final response = await api.get('/orders/my-orders');

      return List<Order>.from(response.data.map((x) => Order.fromJson(x)));
    } catch (e) {
      throw ServiceException('An error occurred while loading the orders.', e);
    }
  }

  static Future<Order> getOrder({
    required int orderId,
  }) async {
    try {
      final response = await api.get('/orders/$orderId');

      return Order.fromJson(response.data);
    } catch (e) {
      throw ServiceException('An error occurred while loading the order.', e);
    }
  }
}
