import 'package:fooddash/app/config/constants/environment.dart';
import 'package:fooddash/app/config/constants/storage_keys.dart';
import 'package:fooddash/app/features/core/services/storage_service.dart';
import 'package:dio/dio.dart';

final Dio _dioBase = Dio(BaseOptions(baseUrl: '${Environment.baseUrl}/api'));

InterceptorsWrapper _interceptor = InterceptorsWrapper(
  onRequest: (options, handler) async {
    final token = await StorageService.get<String>(StorageKeys.token);
    options.headers['Authorization'] = 'Bearer $token';
    options.headers['Accept'] = 'application/json';

    return handler.next(options);
  },
);

class Api {
  static Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    _dioBase.interceptors.add(_interceptor);
    return _dioBase.get(path, queryParameters: queryParameters);
  }

  static Future<Response> post(String path, {Object? data}) async {
    _dioBase.interceptors.add(_interceptor);
    return _dioBase.post(path, data: data);
  }

  static Future<Response> put(String path, {Object? data}) async {
    _dioBase.interceptors.add(_interceptor);
    return _dioBase.put(path, data: data);
  }

  static Future<Response> delete(String path) async {
    _dioBase.interceptors.add(_interceptor);
    return _dioBase.delete(path);
  }
}
