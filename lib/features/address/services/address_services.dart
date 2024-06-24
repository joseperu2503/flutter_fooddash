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
      throw ServiceException('An error occurred while loading the addresses.');
    }
  }

  static showAddressBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      useRootNavigator: true,
      elevation: 0,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      builder: (BuildContext context) {
        return const AddressBottomSheet();
      },
    );
  }
}
