import 'package:flutter/material.dart';
import 'package:fooddash/config/api/api.dart';
import 'package:fooddash/features/address/models/address.dart';
import 'package:fooddash/features/address/widgets/address_bottom_sheet.dart';
import 'package:fooddash/features/core/models/service_exception.dart';

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

  static Future<void> createAddress({
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

      await api.post('/addresses', data: form);
    } catch (e) {
      throw ServiceException(
          'An error occurred while registering the address.', e);
    }
  }

  static showAddressBottomSheet(
    BuildContext context, {
    bool isDismissible = true,
  }) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      useRootNavigator: true,
      elevation: 0,
      isScrollControlled: true,
      isDismissible: isDismissible,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      showDragHandle: false,
      enableDrag: isDismissible,
      builder: (BuildContext context) {
        return const AddressBottomSheet();
      },
    );
  }
}
