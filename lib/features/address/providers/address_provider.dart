import 'dart:async';
import 'package:delivery_app/features/address/models/search_address_response.dart';
import 'package:delivery_app/features/address/services/address_service.dart';
import 'package:delivery_app/features/core/models/service_exception.dart';
import 'package:delivery_app/features/core/services/snackbar_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      final SearchAddressResponse response =
          await AddressService.searchAddresses(
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
}

class SearchState {
  final List<AddressResult> addressResults;
  final String search;
  final bool loadingAddresses;

  SearchState({
    this.addressResults = const [],
    this.search = '',
    this.loadingAddresses = false,
  });

  SearchState copyWith({
    List<AddressResult>? addressResults,
    String? search,
    bool? loadingAddresses,
  }) =>
      SearchState(
        addressResults: addressResults ?? this.addressResults,
        search: search ?? this.search,
        loadingAddresses: loadingAddresses ?? this.loadingAddresses,
      );
}
