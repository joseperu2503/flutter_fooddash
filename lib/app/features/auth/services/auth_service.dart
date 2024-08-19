import 'package:fooddash/app/config/api/api.dart';
import 'package:fooddash/app/config/constants/storage_keys.dart';
import 'package:fooddash/app/features/auth/models/login_response.dart';
import 'package:fooddash/app/features/auth/models/auth_user.dart';
import 'package:fooddash/app/features/core/models/service_exception.dart';
import 'package:fooddash/app/features/core/services/storage_service.dart';
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
      throw ServiceException('An error occurred while trying to log in.', e);
    }
  }

  static Future<LoginResponse> loginGoogle({required String idToken}) async {
    try {
      Map<String, dynamic> form = {
        "idToken": idToken,
      };

      final response = await Api().post('/auth/login-google', data: form);

      return LoginResponse.fromJson(response.data);
    } catch (e) {
      throw ServiceException('An error occurred while trying to log in.', e);
    }
  }

  static Future<AuthUser> getUser() async {
    try {
      final response = await Api().get('/auth/me');

      return AuthUser.fromJson(response.data);
    } catch (e) {
      throw ServiceException('An error occurred while loading the user.', e);
    }
  }

  static Future<AuthUser> changePersonalData({
    required String name,
    required String surname,
    required String email,
    required String phone,
  }) async {
    try {
      Map<String, dynamic> form = {
        "name": name,
        "surname": surname,
        "email": email,
        "phone": phone,
      };
      final response = await Api().put('/auth/update', data: form);

      return AuthUser.fromJson(response.data);
    } catch (e) {
      throw ServiceException(
          'An error occurred while changing the personal data.', e);
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
