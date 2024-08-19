import 'package:dio/dio.dart';

class ApiMapbox {
  final Dio _dioBase = Dio(BaseOptions(baseUrl: 'https://api.mapbox.com'));

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dioBase.get(path, queryParameters: queryParameters);
  }
}
