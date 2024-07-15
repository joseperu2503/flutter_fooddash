import 'package:fooddash/app/config/constants/environment.dart';
import 'package:dio/dio.dart';

class ApiMercadoPago {
  final Dio _dioBase = Dio(BaseOptions(baseUrl: Environment.mpUrl));

  Future<Response> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dioBase.post(path, data: data, queryParameters: queryParameters);
  }
}
