import 'package:fooddash/app/config/api/api.dart';
import 'package:fooddash/app/features/address/models/address.dart';
import 'package:fooddash/app/features/address/models/address_result.dart';
import 'package:fooddash/app/features/address/models/geocode_response.dart';
import 'package:fooddash/app/features/address/models/place_details.dart';
import 'package:fooddash/app/features/core/models/service_exception.dart';

final api = Api();

class AddressService {
  static Future<List<Address>> getMyAddresses() async {
    try {
      final response = await api.get('/addresses/my-addresses');

      return List<Address>.from(response.data.map((x) => Address.fromJson(x)));
    } catch (e) {
      throw ServiceException(
          'An error occurred while loading the addresses.', e);
    }
  }

  static Future<Address> createAddress({
    required String country,
    required String city,
    required double latitude,
    required double longitude,
    required String address,
    required String detail,
    required String references,
    required int? addressTagId,
    required int? addressDeliveryDetailId,
  }) async {
    try {
      Map<String, dynamic> form = {
        "city": city,
        "country": country,
        "address": address,
        "detail": detail,
        "references": references,
        "latitude": latitude,
        "longitude": longitude,
        "addressTagId": addressTagId,
        "addressDeliveryDetailId": addressDeliveryDetailId,
      };

      final response = await api.post('/addresses', data: form);
      return Address.fromJson(response.data);
    } catch (e) {
      throw ServiceException(
          'An error occurred while registering the address.', e);
    }
  }

  static Future<List<AddressResult>> autocomplete(
      {required String query}) async {
    try {
      Map<String, dynamic> queryParameters = {
        "input": query,
      };

      final response = await api.get(
        '/addresses/autocomplete',
        queryParameters: queryParameters,
      );

      return List<AddressResult>.from(
          response.data.map((x) => AddressResult.fromJson(x)));
    } catch (e) {
      throw ServiceException(
          'An error occurred while searching the address.', e);
    }
  }

  static Future<PlaceDetails> placeDetails({
    required String placeId,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {
        "placeId": placeId,
      };

      final response = await api.get(
        '/addresses/place-details',
        queryParameters: queryParameters,
      );

      return PlaceDetails.fromJson(response.data);
    } catch (e) {
      throw ServiceException(
          'An error occurred while searching the address.', e);
    }
  }

  static Future<GeocodeResponse> geocode({
    required double latitude,
    required double longitude,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {
        "lat": latitude,
        "lng": longitude,
      };

      final response = await api.get(
        '/addresses/geocode',
        queryParameters: queryParameters,
      );

      return GeocodeResponse.fromJson(response.data);
    } catch (e) {
      throw ServiceException(
          'An error occurred while searching the address.', e);
    }
  }
}
