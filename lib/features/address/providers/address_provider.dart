// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:delivery_app/features/address/models/search_address_response.dart';
import 'package:delivery_app/features/address/services/mapbox_service.dart';
import 'package:delivery_app/features/core/models/service_exception.dart';
import 'package:delivery_app/features/core/services/snackbar_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final searchAddressProvider =
    StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  return SearchNotifier(ref);
});

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier(this.ref) : super(SearchState());
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

  LatLng? cameraPosition;

  Future<void> searchLocality(LatLng newCameraPosition) async {
    try {
      cameraPosition = newCameraPosition;

      final MapboxResponse response = await MapBoxService.geocode(
        latitude: newCameraPosition.latitude,
        longitude: newCameraPosition.longitude,
      );

      if (newCameraPosition == cameraPosition) {
        if (response.features.isNotEmpty &&
            response.features[0].properties.namePreferred != null &&
            response.features[0].properties.context.country?.name != null) {
          state = state.copyWith(
            district: () => District(
              name: response.features[0].properties.namePreferred!,
              country: response.features[0].properties.context.country!.name!,
            ),
          );
        } else {
          state = state.copyWith(
            district: () => null,
          );
        }
      }
    } on ServiceException catch (_) {
      if (newCameraPosition == cameraPosition) {
        state = state.copyWith(
          district: () => null,
        );
      }
    }
  }

  Future<void> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      throw 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        throw 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      throw 'Location permissions are permanently denied, we cannot request permissions.';
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final location = await Geolocator.getCurrentPosition();
    state = state.copyWith(
      currentPosition: () => location,
    );
  }
}

class SearchState {
  final List<Feature> addressResults;
  final String search;
  final bool loadingAddresses;
  final District? district;
  final Position? currentPosition;

  SearchState({
    this.addressResults = const [],
    this.search = '',
    this.loadingAddresses = false,
    this.district,
    this.currentPosition,
  });

  SearchState copyWith({
    List<Feature>? addressResults,
    String? search,
    bool? loadingAddresses,
    ValueGetter<District?>? district,
    ValueGetter<Position?>? currentPosition,
  }) =>
      SearchState(
        addressResults: addressResults ?? this.addressResults,
        search: search ?? this.search,
        loadingAddresses: loadingAddresses ?? this.loadingAddresses,
        district: district != null ? district() : this.district,
        currentPosition:
            currentPosition != null ? currentPosition() : this.currentPosition,
      );
}

class District {
  String name;
  String country;

  District({
    required this.name,
    required this.country,
  });
}
