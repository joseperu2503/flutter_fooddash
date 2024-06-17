import 'package:fooddash/config/api/api.dart';
import 'package:fooddash/config/constants/storage_keys.dart';
import 'package:fooddash/features/auth/models/login_response.dart';
import 'package:fooddash/features/core/services/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService {
  static Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      Map<String, dynamic> form = {
        "email": email,
        "password": password,
      };

      final response = await Api().post('/auth/login', data: form);

      return LoginResponse.fromJson(response.data);
    } catch (e) {
      String errorMessage = 'An error occurred while trying to log in.';

      if (e is DioException) {
        if (e.response?.data['message'] != null) {
          errorMessage = e.response?.data['message'];
        }
      }

      throw errorMessage;
    }
  }

  static Future<(bool, int)> verifyToken() async {
    final token = await StorageService.get<String>(StorageKeys.token);
    if (token == null) return (false, 0);

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    // Obtiene la marca de tiempo de expiración del token
    int expirationTimestamp = decodedToken['exp'];

    // Obtiene la marca de tiempo actual
    int currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    //si el token es invalido

    // Calcula el tiempo restante hasta la expiración en segundos
    int timeRemainingInSeconds = expirationTimestamp - currentTimestamp;

    if (timeRemainingInSeconds <= 0) {
      return (false, 0);
    }
    return (true, timeRemainingInSeconds);
  }
}
