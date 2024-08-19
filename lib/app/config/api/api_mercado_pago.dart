import 'package:dio/dio.dart';

class ApiMercadoPago {
  final Dio _dioBase = Dio(BaseOptions(baseUrl: 'https://api.mercadopago.com'));

  Future<Response> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dioBase.post(path, data: data, queryParameters: queryParameters);
  }
}
