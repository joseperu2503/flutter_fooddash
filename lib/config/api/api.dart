import 'package:fooddash/config/constants/environment.dart';
import 'package:fooddash/config/constants/storage_keys.dart';
import 'package:fooddash/features/core/services/storage_service.dart';
import 'package:dio/dio.dart';

class Api {
  final Dio _dioBase = Dio(BaseOptions(baseUrl: Environment.baseUrl));

  InterceptorsWrapper interceptor = InterceptorsWrapper();

  Api() {
    interceptor = InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await StorageService.get<String>(StorageKeys.token);
        options.headers['Authorization'] = 'Bearer $token';
        options.headers['Accept'] = 'application/json';

        return handler.next(options);
      },
    );
    _dioBase.interceptors.add(interceptor);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dioBase.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {Object? data}) async {
    return _dioBase.post(path, data: data);
  }

  Future<Response> put(String path, {Object? data}) async {
    return _dioBase.put(path, data: data);
  }

  Future<Response> delete(String path) async {
    return _dioBase.delete(path);
  }
}
