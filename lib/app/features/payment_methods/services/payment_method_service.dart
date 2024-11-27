import 'package:fooddash/app/config/api/api.dart';
import 'package:fooddash/app/config/api/api_mercado_pago.dart';
import 'package:fooddash/app/config/constants/environment.dart';
import 'package:fooddash/app/features/core/models/service_exception.dart';
import 'package:fooddash/app/features/payment_methods/models/card_token_response.dart';
import 'package:fooddash/app/features/payment_methods/models/payment_methods.dart';

final apiMercadoPago = ApiMercadoPago();

class PaymentMethodService {
  static Future<List<PaymentMethod>> getMyPaymentMethods() async {
    try {
      final response = await Api.get('/payment-methods/my-payment-methods');

      return List<PaymentMethod>.from(
          response.data.map((x) => PaymentMethod.fromJson(x)));
    } catch (e) {
      throw ServiceException(
          'An error occurred while loading the payment methods.', e);
    }
  }

  static Future<CardTokenResponse> createCardTokenMP({
    required String cardNumber,
    required String name,
    required String? email,
    required int expirationYear,
    required int expirationMonth,
  }) async {
    try {
      Map<String, dynamic> form = {
        "cardNumber": cardNumber,
        "email": email,
        "cardholder": {
          "name": name,
        },
        "expirationYear": expirationYear,
        "expirationMonth": expirationMonth,
      };

      Map<String, dynamic> queryParameters = {
        "public_key": Environment.mpPublicKey,
      };

      final response = await apiMercadoPago.post(
        '/v1/card_tokens',
        data: form,
        queryParameters: queryParameters,
      );

      return CardTokenResponse.fromJson(response.data);
    } catch (e) {
      throw ServiceException(
          'An error occurred while registering the card.', e);
    }
  }

  static Future<void> saveCard({
    required String token,
  }) async {
    try {
      Map<String, dynamic> form = {
        "token": token,
      };

      await Api.post(
        '/cards',
        data: form,
      );
    } catch (e) {
      throw ServiceException(
          'An error occurred while registering the card.', e);
    }
  }

  static Future<void> deleteCard({
    required String cardId,
  }) async {
    try {
      await Api.delete(
        '/cards/$cardId',
      );
    } catch (e) {
      throw ServiceException('An error occurred while deleting the card.', e);
    }
  }
}
