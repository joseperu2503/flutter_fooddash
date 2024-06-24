import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/features/address/models/address.dart';
import 'package:fooddash/features/address/models/search_address_response.dart';
import 'package:fooddash/features/address/services/mapbox_service.dart';
import 'package:fooddash/features/address/services/address_services.dart';
import 'package:fooddash/features/core/models/service_exception.dart';
import 'package:fooddash/features/core/services/snackbar_service.dart';
import 'package:fooddash/features/shared/models/form_type.dart';
import 'package:fooddash/features/shared/models/loading_status.dart';
import 'package:fooddash/features/shared/plugins/formx/formx.dart';
import 'package:fooddash/features/shared/providers/map_provider.dart';
import 'package:fooddash/features/shared/services/snackbar_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final addressProvider =
    StateNotifierProvider<AddressNotifier, AddressState>((ref) {
  return AddressNotifier(ref);
});

class AddressNotifier extends StateNotifier<AddressState> {
  AddressNotifier(this.ref) : super(AddressState());
  final StateNotifierProviderRef ref;

  resetForm() {
    state = state.copyWith(
      city: const FormxInput(value: ''),
      country: const FormxInput(value: ''),
      address: const FormxInput(value: ''),
      tag: () => null,
      deliveryDetail: () => null,
    );
    changeSearch('');
  }

  Future<void> searchAddress() async {
    state = state.copyWith(
      searchingAddresses: LoadingStatus.loading,
    );

    final search = state.search;

    try {
      final MapboxResponse response = await MapBoxService.searchbox(
        query: state.search,
      );

      if (search == state.search) {
        state = state.copyWith(
          addressResults: response.features,
          searchingAddresses: LoadingStatus.success,
        );
      }
    } on ServiceException catch (e) {
      if (search == state.search) {
        SnackbarService.showSnackbar(e.message);
        state = state.copyWith(
          searchingAddresses: LoadingStatus.error,
        );
      }
    }
  }

  Timer? _debounceTimer;

  changeSearch(String newSearch) {
    state = state.copyWith(
      addressResults: [],
      search: newSearch,
      searchingAddresses:
          newSearch != '' ? LoadingStatus.loading : LoadingStatus.none,
    );
    if (newSearch == '') return;

    final search = state.search;

    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();
    _debounceTimer = Timer(
      const Duration(milliseconds: 1000),
      () {
        if (search != state.search) return;
        searchAddress();
      },
    );
  }

  Future<void> searchLocality() async {
    LatLng? cameraPosition = ref.read(mapProvider).cameraPosition;
    if (cameraPosition == null) return;
    try {
      final MapboxResponse response = await MapBoxService.geocode(
        latitude: cameraPosition.latitude,
        longitude: cameraPosition.longitude,
      );

      if (cameraPosition == ref.read(mapProvider).cameraPosition) {
        if (response.features.isNotEmpty &&
            response.features[0].properties.context.locality?.name != null &&
            response.features[0].properties.context.country?.name != null &&
            response.features[0].properties.context.street?.name != null) {
          state = state.copyWith(
            city: state.city.updateValue(
                response.features[0].properties.context.locality!.name!),
            country: state.country.updateValue(
                response.features[0].properties.context.country!.name!),
            address: state.address.updateValue(
                response.features[0].properties.context.street!.name!),
          );
        } else {
          state = state.copyWith(
            city: state.city.updateValue(''),
            country: state.country.updateValue(''),
            address: state.address.updateValue(''),
          );
        }
      }
    } on ServiceException catch (_) {
      if (cameraPosition == ref.read(mapProvider).cameraPosition) {
        state = state.copyWith(
          city: state.city.updateValue(''),
          country: state.country.updateValue(''),
          address: state.address.updateValue(''),
        );
      }
    }
  }

  Future<void> getMyAddresses() async {
    if (state.loadingAddresses == LoadingStatus.loading) return;

    state = state.copyWith(
      loadingAddresses: LoadingStatus.loading,
      addresses: [],
    );

    try {
      final List<Address> response = await AddressService.getMyAddresses();
      state = state.copyWith(
        addresses: [...state.addresses, ...response],
        loadingAddresses: LoadingStatus.success,
      );
    } on ServiceException catch (e) {
      SnackBarService.show(e.message);

      state = state.copyWith(
        loadingAddresses: LoadingStatus.error,
      );
    }
  }

  void changeTag(Tag tag) {
    state = state.copyWith(
      tag: () => tag,
    );
  }

  void changeDelivery(DeliveryDetail deliveryDetail) {
    state = state.copyWith(
      deliveryDetail: () => deliveryDetail,
    );
  }

  void changeDetail(FormxInput<String> detail) {
    state = state.copyWith(
      detail: detail,
    );
  }

  void changeReferences(FormxInput<String> references) {
    state = state.copyWith(
      references: references,
    );
  }
}

class AddressState {
  final List<Feature> addressResults;
  final String search;
  final LoadingStatus searchingAddresses;
  final Tag? tag;
  final DeliveryDetail? deliveryDetail;
  final FormxInput<String> city;
  final FormxInput<String> country;
  final FormxInput<String> address;
  final FormxInput<String> detail;
  final FormxInput<String> references;
  final List<Address> addresses;
  final LoadingStatus loadingAddresses;

  AddressState({
    this.addressResults = const [],
    this.search = '',
    this.searchingAddresses = LoadingStatus.none,
    this.tag,
    this.deliveryDetail,
    this.city = const FormxInput(value: ''),
    this.country = const FormxInput(value: ''),
    this.address = const FormxInput(value: ''),
    this.detail = const FormxInput(value: ''),
    this.references = const FormxInput(value: ''),
    this.addresses = const [],
    this.loadingAddresses = LoadingStatus.none,
  });

  AddressState copyWith({
    List<Feature>? addressResults,
    String? search,
    LoadingStatus? searchingAddresses,
    ValueGetter<Position?>? currentPosition,
    ValueGetter<Tag?>? tag,
    ValueGetter<DeliveryDetail?>? deliveryDetail,
    FormxInput<String>? city,
    FormxInput<String>? country,
    FormxInput<String>? address,
    FormxInput<String>? detail,
    FormxInput<String>? references,
    List<Address>? addresses,
    LoadingStatus? loadingAddresses,
  }) =>
      AddressState(
        addressResults: addressResults ?? this.addressResults,
        search: search ?? this.search,
        searchingAddresses: searchingAddresses ?? this.searchingAddresses,
        tag: tag != null ? tag() : this.tag,
        deliveryDetail:
            deliveryDetail != null ? deliveryDetail() : this.deliveryDetail,
        city: city ?? this.city,
        country: country ?? this.country,
        address: address ?? this.address,
        detail: detail ?? this.detail,
        references: references ?? this.references,
        addresses: addresses ?? this.addresses,
        loadingAddresses: loadingAddresses ?? this.loadingAddresses,
      );
}

List<Tag> tags = [
  Tag(
    id: 1,
    name: 'Home',
    icon: 'assets/icons/tabs/home_outlined.svg',
  ),
  Tag(
    id: 2,
    name: 'Office',
    icon: 'assets/icons/suitcase.svg',
  ),
  Tag(
    id: 3,
    name: 'Partner',
    icon: 'assets/icons/tabs/heart_outlined.svg',
  ),
];

List<DeliveryDetail> deliveryDetails = [
  DeliveryDetail(
    id: 1,
    name: 'Personal',
  ),
  DeliveryDetail(
    id: 2,
    name: 'Lobby',
  ),
];

class Tag {
  int id;
  String name;
  String icon;
  Tag({
    required this.id,
    required this.name,
    required this.icon,
  });
}

class DeliveryDetail {
  int id;
  String name;
  DeliveryDetail({
    required this.id,
    required this.name,
  });
}
