import 'package:dio/dio.dart';

class ServiceException implements Exception {
  final String errorMessage;
  final dynamic e;

  ServiceException(this.errorMessage, this.e);

  String get message {
    if (e is DioException) {
      try {
        if (e.response?.data['message'] != null &&
            e.response?.data['message'] is String &&
            e.response?.data['message'] != '') {
          return e.response?.data['message'];
        }
      } catch (_) {}
    }

    return errorMessage;
  }
}
