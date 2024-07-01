import 'package:fooddash/config/api/api.dart';
import 'package:fooddash/config/api/api_mercado_pago.dart';
import 'package:fooddash/config/constants/environment.dart';
import 'package:fooddash/features/address/models/address.dart';
import 'package:fooddash/features/core/models/service_exception.dart';

final api = Api();
final apiMercadoPago = ApiMercadoPago();

class PaymentMethodService {
  static Future<List<Address>> getMyAddresses() async {
    try {
      final response = await api.get('/addresses/my-addresses');

      return List<Address>.from(response.data.map((x) => Address.fromJson(x)));
    } catch (e) {
      throw ServiceException(
          'An error occurred while loading the addresses.', e);
    }
  }

  static Future<void> createCardTokenMP({
    required String cardNumber,
    required String name,
    required int expirationYear,
    required int expirationMonth,
  }) async {
    try {
      Map<String, dynamic> form = {
        "cardNumber": cardNumber,
        "name": name,
        "expirationYear": expirationYear,
        "expirationMonth": expirationMonth,
      };

      Map<String, dynamic> queryParameters = {
        "public_key": Environment.mpPublicKey,
      };

      await apiMercadoPago.post(
        '/v1/card_tokens',
        data: form,
        queryParameters: queryParameters,
      );
    } catch (e) {
      throw ServiceException(
          'An error occurred while registering the card.', e);
    }
  }
}
