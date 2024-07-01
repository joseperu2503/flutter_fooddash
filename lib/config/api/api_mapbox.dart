import 'package:fooddash/config/constants/environment.dart';

import 'package:dio/dio.dart';

class ApiMapbox {
  final Dio _dioBase = Dio(BaseOptions(baseUrl: Environment.mapboxUrl));

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dioBase.get(path, queryParameters: queryParameters);
  }
}
