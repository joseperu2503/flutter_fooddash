import 'package:delivery_app/config/api/api_mapbox.dart';
import 'package:delivery_app/config/constants/environment.dart';
import 'package:delivery_app/features/address/models/search_address_response.dart';
import 'package:delivery_app/features/core/models/service_exception.dart';

class AddressService {
  static Future<SearchAddressResponse> searchAddresses(
      {required String query}) async {
    try {
      Map<String, dynamic> queryParameters = {
        "q": query,
        "access_token": Environment.tokenMapbox,
        "country": "pe",
        "language": "es",
      };

      final response = await ApiMapbox.get(
        '/search/searchbox/v1/forward',
        queryParameters: queryParameters,
      );

      return SearchAddressResponse.fromJson(response.data);
    } catch (e) {
      throw ServiceException('An error occurred while searching the address.');
    }
  }
}
