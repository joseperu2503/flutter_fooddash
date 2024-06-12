import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_fooddash/features/address/models/search_address_response.dart';
import 'package:flutter_fooddash/features/address/services/mapbox_service.dart';
import 'package:flutter_fooddash/features/core/models/service_exception.dart';
import 'package:flutter_fooddash/features/core/services/snackbar_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

final addressProvider =
    StateNotifierProvider<AddressNotifier, AddressState>((ref) {
  return AddressNotifier(ref);
});

class AddressNotifier extends StateNotifier<AddressState> {
  AddressNotifier(this.ref)
      : super(AddressState(
          address: FormControl<String>(value: ''),
        ));
  final StateNotifierProviderRef ref;

  Future<void> searchProducts() async {
    state = state.copyWith(
      loadingAddresses: true,
    );

    final search = state.search;
    try {
      final MapboxResponse response = await MapBoxService.searchbox(
        query: state.search,
      );

      if (search == state.search) {
        state = state.copyWith(
          addressResults: response.features,
        );
      }
    } on ServiceException catch (e) {
      if (search == state.search) {
        SnackbarService.showSnackbar(e.message);
      }
    }
    if (search == state.search) {
      state = state.copyWith(
        loadingAddresses: false,
      );
    }
  }

  Timer? _debounceTimer;

  changeSearch(String newSearch) {
    state = state.copyWith(
      addressResults: [],
      search: newSearch,
      loadingAddresses: newSearch != '',
    );
    if (newSearch == '') return;

    final search = state.search;

    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();
    _debounceTimer = Timer(
      const Duration(milliseconds: 1000),
      () {
        if (search != state.search) return;
        searchProducts();
      },
    );
  }

  Future<void> searchLocality() async {
    LatLng? cameraPosition = state.cameraPosition;
    if (cameraPosition == null) return;
    try {
      final MapboxResponse response = await MapBoxService.geocode(
        latitude: cameraPosition.latitude,
        longitude: cameraPosition.longitude,
      );

      if (cameraPosition == state.cameraPosition) {
        if (response.features.isNotEmpty &&
            response.features[0].properties.namePreferred != null &&
            response.features[0].properties.context.country?.name != null) {
          state = state.copyWith(
            locality: () => Locality(
              city: response.features[0].properties.namePreferred!,
              country: response.features[0].properties.context.country!.name!,
            ),
          );
        } else {
          state = state.copyWith(
            locality: () => null,
          );
        }
      }
    } on ServiceException catch (_) {
      if (cameraPosition == state.cameraPosition) {
        state = state.copyWith(
          locality: () => null,
        );
      }
    }
  }

  void changeCameraPosition(LatLng newCameraPosition) {
    state = state.copyWith(
      cameraPosition: () => newCameraPosition,
    );
  }

  void changeAddress(FormControl<String> address) {
    state = state.copyWith(
      address: address,
    );
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
}

class AddressState {
  final List<Feature> addressResults;
  final String search;
  final bool loadingAddresses;
  final Locality? locality;
  final LatLng? cameraPosition;
  final FormControl<String> address;
  final Tag? tag;
  final DeliveryDetail? deliveryDetail;

  AddressState({
    this.addressResults = const [],
    this.search = '',
    this.loadingAddresses = false,
    this.locality,
    this.cameraPosition,
    required this.address,
    this.tag,
    this.deliveryDetail,
  });

  AddressState copyWith({
    List<Feature>? addressResults,
    String? search,
    bool? loadingAddresses,
    ValueGetter<Locality?>? locality,
    ValueGetter<Position?>? currentPosition,
    ValueGetter<LatLng?>? cameraPosition,
    FormControl<String>? address,
    ValueGetter<Tag?>? tag,
    ValueGetter<DeliveryDetail?>? deliveryDetail,
  }) =>
      AddressState(
        addressResults: addressResults ?? this.addressResults,
        search: search ?? this.search,
        loadingAddresses: loadingAddresses ?? this.loadingAddresses,
        locality: locality != null ? locality() : this.locality,
        cameraPosition:
            cameraPosition != null ? cameraPosition() : this.cameraPosition,
        address: address ?? this.address,
        tag: tag != null ? tag() : this.tag,
        deliveryDetail:
            deliveryDetail != null ? deliveryDetail() : this.deliveryDetail,
      );
}

class Locality {
  String city;
  String country;

  Locality({
    required this.city,
    required this.country,
  });
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
