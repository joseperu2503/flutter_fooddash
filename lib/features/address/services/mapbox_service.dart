import 'package:fooddash/config/api/api_mapbox.dart';
import 'package:fooddash/config/constants/environment.dart';
import 'package:fooddash/features/address/models/search_address_response.dart';
import 'package:fooddash/features/core/models/service_exception.dart';

class MapBoxService {
  static Future<MapboxResponse> searchbox({required String query}) async {
    try {
      Map<String, dynamic> queryParameters = {
        "q": query,
        "access_token": Environment.tokenMapbox,
        "country": "pe",
        "language": "en",
      };

      final response = await ApiMapbox.get(
        '/search/searchbox/v1/forward',
        queryParameters: queryParameters,
      );

      return MapboxResponse.fromJson(response.data);
    } catch (e) {
      throw ServiceException(
          'An error occurred while searching the address.', e);
    }
  }

  static Future<MapboxResponse> geocode({
    required double latitude,
    required double longitude,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {
        "access_token": Environment.tokenMapbox,
        // "country": "pe",
        "language": "en",
        "types": "place,locality,street",
        "longitude": longitude,
        "latitude": latitude,
      };

      final response = await ApiMapbox.get(
        '/search/geocode/v6/reverse',
        queryParameters: queryParameters,
      );

      return MapboxResponse.fromJson(response.data);
    } catch (e) {
      throw ServiceException(
          'An error occurred while searching the address.', e);
    }
  }
}
