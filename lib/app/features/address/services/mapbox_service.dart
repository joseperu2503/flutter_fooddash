import 'package:fooddash/app/config/api/api_mapbox.dart';
import 'package:fooddash/app/config/constants/environment.dart';
import 'package:fooddash/app/features/address/models/search_address_response.dart';
import 'package:fooddash/app/features/core/models/service_exception.dart';

final apiMapbox = ApiMapbox();

class MapBoxService {
  static Future<MapboxResponse> searchbox({required String query}) async {
    try {
      Map<String, dynamic> queryParameters = {
        "q": query,
        "access_token": Environment.mapboxToken,
        "country": "pe",
        "language": "en",
      };

      final response = await apiMapbox.get(
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
        "access_token": Environment.mapboxToken,
        // "country": "pe",
        "language": "en",
        "types": "place,locality,street",
        "longitude": longitude,
        "latitude": latitude,
      };

      final response = await apiMapbox.get(
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
