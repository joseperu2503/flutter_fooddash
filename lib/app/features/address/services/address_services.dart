import 'package:fooddash/app/config/api/api.dart';
import 'package:fooddash/app/features/address/models/address.dart';
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
}
