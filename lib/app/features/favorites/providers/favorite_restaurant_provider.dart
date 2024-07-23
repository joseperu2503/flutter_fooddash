import 'package:fooddash/app/features/core/models/service_exception.dart';
import 'package:fooddash/app/features/dashboard/models/restaurant.dart';
import 'package:fooddash/app/features/dashboard/providers/restaurants_provider.dart';
import 'package:fooddash/app/features/dashboard/services/restaurants_service.dart';
import 'package:fooddash/app/features/restaurant/models/restaurant.dart';
import 'package:fooddash/app/features/shared/models/loading_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/features/shared/services/snackbar_service.dart';

final favoriteRestaurantProvider =
    StateNotifierProvider<RestaurantsNotifier, RestaurantsState>((ref) {
  return RestaurantsNotifier(ref);
});

class RestaurantsNotifier extends StateNotifier<RestaurantsState> {
  RestaurantsNotifier(this.ref) : super(RestaurantsState());
  final StateNotifierProviderRef ref;

  initData() {
    state = state.copyWith(
      restaurants: [],
      page: 1,
      totalPages: 1,
      loadingStatus: LoadingStatus.none,
    );
  }

  Future<void> getRestaurants() async {
    if (state.page > state.totalPages ||
        state.loadingStatus == LoadingStatus.loading) return;

    state = state.copyWith(
      loadingStatus: LoadingStatus.loading,
    );

    try {
      final RestaurantsResponse response =
          await RestaurantsService.getFavorites(
        page: state.page,
      );
      state = state.copyWith(
        restaurants: [...state.restaurants, ...response.items],
        totalPages: response.meta.totalPages,
        page: state.page + 1,
        loadingStatus: LoadingStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        loadingStatus: LoadingStatus.error,
      );
      rethrow;
    }
  }

  toggleFavorite({required int restaurantId}) async {
    try {
      final Restaurant restaurant =
          await RestaurantsService.toggleFavorite(restaurantId: restaurantId);

      ref.read(restaurantsProvider.notifier).setRestaurant(restaurant);

      initData();
      getRestaurants();
    } on ServiceException catch (e) {
      SnackBarService.show(e.message);
    }
  }
}

class RestaurantsState {
  final List<Restaurant> restaurants;
  final int page;
  final int totalPages;
  final LoadingStatus loadingStatus;

  RestaurantsState({
    this.restaurants = const [],
    this.page = 1,
    this.totalPages = 1,
    this.loadingStatus = LoadingStatus.none,
  });

  RestaurantsState copyWith({
    List<Restaurant>? restaurants,
    int? page,
    int? totalPages,
    LoadingStatus? loadingStatus,
  }) =>
      RestaurantsState(
        restaurants: restaurants ?? this.restaurants,
        page: page ?? this.page,
        totalPages: totalPages ?? this.totalPages,
        loadingStatus: loadingStatus ?? this.loadingStatus,
      );
}
