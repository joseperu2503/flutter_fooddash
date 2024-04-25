import 'package:delivery_app/config/constants/environment.dart';

import 'package:dio/dio.dart';

class ApiMapbox {
  static final Dio _dioBase = Dio(BaseOptions(baseUrl: Environment.urlMapbox));

  static Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dioBase.get(path, queryParameters: queryParameters);
  }
}
