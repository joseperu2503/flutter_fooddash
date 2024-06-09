import 'package:delivery_app/features/dashboard/models/restaurant.dart';
import 'package:delivery_app/features/dashboard/services/restaurants_services.dart';
import 'package:delivery_app/features/shared/models/loading_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantsProvider =
    StateNotifierProvider<RestaurantsNotifier, RestaurantState>((ref) {
  return RestaurantsNotifier(ref);
});

class RestaurantsNotifier extends StateNotifier<RestaurantState> {
  RestaurantsNotifier(this.ref) : super(RestaurantState());
  final StateNotifierProviderRef ref;

  initData() {
    state = state.copyWith(
      restaurants: [],
      page: 1,
      totalPages: 1,
      dashboardStatus: LoadingStatus.none,
    );
  }

  Future<void> getRestaurants() async {
    if (state.page > state.totalPages ||
        state.dashboardStatus == LoadingStatus.loading) return;

    state = state.copyWith(
      dashboardStatus: LoadingStatus.loading,
    );

    try {
      final List<Restaurant> response =
          await RestaurantsService.getRestaurants();
      state = state.copyWith(
        restaurants: [...state.restaurants, ...response],
        totalPages: 1,
        page: state.page + 1,
        dashboardStatus: LoadingStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        dashboardStatus: LoadingStatus.error,
      );
      rethrow;
    }
  }
}

class RestaurantState {
  final List<Restaurant> restaurants;
  final int page;
  final int totalPages;
  final LoadingStatus dashboardStatus;

  RestaurantState({
    this.restaurants = const [],
    this.page = 1,
    this.totalPages = 1,
    this.dashboardStatus = LoadingStatus.none,
  });

  RestaurantState copyWith({
    List<Restaurant>? restaurants,
    int? page,
    int? totalPages,
    LoadingStatus? dashboardStatus,
  }) =>
      RestaurantState(
        restaurants: restaurants ?? this.restaurants,
        page: page ?? this.page,
        totalPages: totalPages ?? this.totalPages,
        dashboardStatus: dashboardStatus ?? this.dashboardStatus,
      );
}
