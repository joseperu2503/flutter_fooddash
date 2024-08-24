import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/config/router/app_router.dart';
import 'package:fooddash/app/features/address/models/address.dart';
import 'package:fooddash/app/features/address/models/address_result.dart';
import 'package:fooddash/app/features/address/models/geocode_response.dart';
import 'package:fooddash/app/features/address/services/address_services.dart';
import 'package:fooddash/app/features/core/models/service_exception.dart';
import 'package:fooddash/app/features/core/services/snackbar_service.dart';
import 'package:fooddash/app/features/shared/models/loading_status.dart';
import 'package:fooddash/app/features/shared/plugins/formx/formx.dart';
import 'package:fooddash/app/features/shared/providers/map_provider.dart';
import 'package:fooddash/app/features/shared/services/snackbar_service.dart';
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
      locality: const FormxInput(value: ''),
      country: const FormxInput(value: ''),
      address: const FormxInput(value: ''),
      tag: () => null,
      deliveryDetail: () => null,
    );
    changeSearch('');
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

  //** Metodo para buscar resultados de direcciones */
  Future<void> searchAddress() async {
    state = state.copyWith(
      searchingAddresses: LoadingStatus.loading,
    );

    final search = state.search;

    try {
      final response = await AddressService.autocomplete(
        query: state.search,
      );

      if (search == state.search) {
        state = state.copyWith(
          addressResults: response,
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

  //** Metodo para seleccionar un resultado y buscar sus coordenadas */
  Future<void> selectAddressResult(AddressResult addressResult) async {
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      final addressResultDetails = await AddressService.placeDetails(
        placeId: addressResult.placeId,
      );

      ref.read(mapProvider.notifier).changeCameraPosition(LatLng(
            addressResultDetails.location.lat,
            addressResultDetails.location.lng,
          ));

      appRouter.push('/address-map');
    } on ServiceException catch (e) {
      SnackbarService.showSnackbar(e.message);
    }
  }

  Future<void> onCameraPositionChange() async {
    LatLng? cameraPosition = ref.read(mapProvider).cameraPosition;
    if (cameraPosition == null) return;
    try {
      final GeocodeResponse response = await AddressService.geocode(
        latitude: cameraPosition.latitude,
        longitude: cameraPosition.longitude,
      );

      if (cameraPosition == ref.read(mapProvider).cameraPosition) {
        state = state.copyWith(
          address: state.address.updateValue(response.address),
          locality: state.locality.updateValue(response.locality),
          country: state.country.updateValue(response.country),
        );
      }
    } on ServiceException catch (_) {
      if (cameraPosition == ref.read(mapProvider).cameraPosition) {
        state = state.copyWith(
          locality: state.locality.updateValue(''),
          country: state.country.updateValue(''),
          address: state.address.updateValue(''),
        );
      }
    }
  }

  Future<void> getMyAddresses({bool withSetAddress = false}) async {
    if (state.loadingAddresses == LoadingStatus.loading) return;

    state = state.copyWith(
      loadingAddresses: LoadingStatus.loading,
      // addresses: [],
    );

    try {
      final List<Address> response = await AddressService.getMyAddresses();
      state = state.copyWith(
        addresses: response,
        loadingAddresses: LoadingStatus.success,
      );
      if (withSetAddress) {
        setAddress();
      }
    } on ServiceException catch (e) {
      SnackBarService.show(e.message);

      state = state.copyWith(
        loadingAddresses: LoadingStatus.error,
      );
    }
  }

  setAddress() {
    if (state.selectedAddress != null) return;

    if (state.addresses.isEmpty) {
      if (rootNavigatorKey.currentContext == null) return;
      appRouter.push('/my-addresses');
    } else {
      state = state.copyWith(
        selectedAddress: () => state.addresses[0],
      );
    }
  }

  Future<void> saveAddress() async {
    LatLng? cameraPosition = ref.read(mapProvider).cameraPosition;
    if (cameraPosition == null) return;

    if (state.savingAddress == LoadingStatus.loading) return;

    state = state.copyWith(
      savingAddress: LoadingStatus.loading,
    );

    try {
      final Address newAddress = await AddressService.createAddress(
        locality: state.locality.value,
        country: state.country.value,
        address: state.address.value,
        detail: state.detail.value,
        latitude: cameraPosition.latitude,
        longitude: cameraPosition.longitude,
        addressDeliveryDetailId: state.deliveryDetail?.id,
        addressTagId: state.tag?.id,
        references: state.references.value,
      );

      await getMyAddresses();

      appRouter.go('/dashboard');
      state = state.copyWith(
        selectedAddress: () => newAddress,
        savingAddress: LoadingStatus.success,
      );
    } on ServiceException catch (e) {
      SnackBarService.show(e.message);

      state = state.copyWith(
        savingAddress: LoadingStatus.error,
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

  void changeSelectedAddress(Address address) {
    state = state.copyWith(
      selectedAddress: () => address,
    );
    appRouter.pop();
  }
}

class AddressState {
  final List<AddressResult> addressResults;
  final String search;
  final LoadingStatus searchingAddresses;
  final Tag? tag;
  final DeliveryDetail? deliveryDetail;
  final FormxInput<String> locality;
  final FormxInput<String> country;
  final FormxInput<String> address;
  final FormxInput<String> detail;
  final FormxInput<String> references;
  final List<Address> addresses;
  final Address? selectedAddress;
  final LoadingStatus loadingAddresses;
  final LoadingStatus savingAddress;

  AddressState({
    this.addressResults = const [],
    this.search = '',
    this.searchingAddresses = LoadingStatus.none,
    this.tag,
    this.deliveryDetail,
    this.locality = const FormxInput(value: ''),
    this.country = const FormxInput(value: ''),
    this.address = const FormxInput(value: ''),
    this.detail = const FormxInput(value: ''),
    this.references = const FormxInput(value: ''),
    this.addresses = const [],
    this.loadingAddresses = LoadingStatus.none,
    this.savingAddress = LoadingStatus.none,
    this.selectedAddress,
  });

  AddressState copyWith({
    List<AddressResult>? addressResults,
    String? search,
    LoadingStatus? searchingAddresses,
    ValueGetter<Position?>? currentPosition,
    ValueGetter<Tag?>? tag,
    ValueGetter<DeliveryDetail?>? deliveryDetail,
    FormxInput<String>? locality,
    FormxInput<String>? country,
    FormxInput<String>? address,
    FormxInput<String>? detail,
    FormxInput<String>? references,
    List<Address>? addresses,
    LoadingStatus? loadingAddresses,
    LoadingStatus? savingAddress,
    ValueGetter<Address?>? selectedAddress,
  }) =>
      AddressState(
        addressResults: addressResults ?? this.addressResults,
        search: search ?? this.search,
        searchingAddresses: searchingAddresses ?? this.searchingAddresses,
        tag: tag != null ? tag() : this.tag,
        deliveryDetail:
            deliveryDetail != null ? deliveryDetail() : this.deliveryDetail,
        locality: locality ?? this.locality,
        country: country ?? this.country,
        address: address ?? this.address,
        detail: detail ?? this.detail,
        references: references ?? this.references,
        addresses: addresses ?? this.addresses,
        loadingAddresses: loadingAddresses ?? this.loadingAddresses,
        savingAddress: savingAddress ?? this.savingAddress,
        selectedAddress:
            selectedAddress != null ? selectedAddress() : this.selectedAddress,
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
