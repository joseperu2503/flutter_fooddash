import 'package:flutter/material.dart';
import 'package:fooddash/app/features/dashboard/models/category.dart';
import 'package:fooddash/app/features/dashboard/models/restaurant.dart';
import 'package:fooddash/app/features/dashboard/services/restaurants_service.dart';
import 'package:fooddash/app/features/restaurant/models/restaurant_detail.dart';
import 'package:fooddash/app/features/shared/models/loading_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantsProvider =
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
      restaurantsStatus: LoadingStatus.none,
      categories: [],
      category: () => null,
      categoriesStatus: LoadingStatus.none,
    );
  }

  Future<void> getRestaurants() async {
    if (state.page > state.totalPages ||
        state.restaurantsStatus == LoadingStatus.loading) return;

    state = state.copyWith(
      restaurantsStatus: LoadingStatus.loading,
    );

    try {
      final RestaurantsResponse response =
          await RestaurantsService.getRestaurants(
        page: state.page,
        restaurantCategoryId: state.category?.id,
      );
      state = state.copyWith(
        restaurants: [...state.restaurants, ...response.items],
        totalPages: response.meta.totalPages,
        page: state.page + 1,
        restaurantsStatus: LoadingStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        restaurantsStatus: LoadingStatus.error,
      );
      rethrow;
    }
  }

  Future<void> getCategories() async {
    if (state.page > state.totalPages ||
        state.categoriesStatus == LoadingStatus.loading) return;

    state = state.copyWith(
      categoriesStatus: LoadingStatus.loading,
    );

    try {
      final List<Category> response = await RestaurantsService.getCategories();
      state = state.copyWith(
        categories: [...state.categories, ...response],
        categoriesStatus: LoadingStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        categoriesStatus: LoadingStatus.error,
      );
      rethrow;
    }
  }

  setTemporalRestaurant(Restaurant restaurant) async {
    state = state.copyWith(
      termporalRestaurant: RestaurantDetail(
        id: restaurant.id,
        name: restaurant.name,
        address: restaurant.address,
        logo: restaurant.logo,
        backdrop: restaurant.backdrop,
        latitude: restaurant.latitude,
        longitude: restaurant.longitude,
        isActive: restaurant.isActive,
        openTime: restaurant.openTime,
        closeTime: restaurant.closeTime,
        dishCategories: [],
        delivery: restaurant.delivery,
        distance: restaurant.distance,
        record: restaurant.record,
        recordPeople: restaurant.recordPeople,
        tags: restaurant.tags,
        time: restaurant.time,
      ),
    );
  }

  setCategory(Category category) {
    state = state.copyWith(
      restaurants: [],
      page: 1,
      totalPages: 1,
      restaurantsStatus: LoadingStatus.none,
      category: () => state.category?.id == category.id ? null : category,
    );
    getRestaurants();
  }
}

class RestaurantsState {
  final List<Restaurant> restaurants;
  final int page;
  final int totalPages;
  final LoadingStatus restaurantsStatus;
  final List<Category> categories;
  final Category? category;
  final LoadingStatus categoriesStatus;
  final RestaurantDetail? termporalRestaurant;

  RestaurantsState({
    this.restaurants = const [],
    this.page = 1,
    this.totalPages = 1,
    this.restaurantsStatus = LoadingStatus.none,
    this.categories = const [],
    this.categoriesStatus = LoadingStatus.none,
    this.termporalRestaurant,
    this.category,
  });

  RestaurantsState copyWith({
    List<Restaurant>? restaurants,
    int? page,
    int? totalPages,
    LoadingStatus? restaurantsStatus,
    List<Category>? categories,
    LoadingStatus? categoriesStatus,
    RestaurantDetail? termporalRestaurant,
    ValueGetter<Category?>? category,
  }) =>
      RestaurantsState(
        restaurants: restaurants ?? this.restaurants,
        page: page ?? this.page,
        totalPages: totalPages ?? this.totalPages,
        restaurantsStatus: restaurantsStatus ?? this.restaurantsStatus,
        categories: categories ?? this.categories,
        categoriesStatus: categoriesStatus ?? this.categoriesStatus,
        termporalRestaurant: termporalRestaurant ?? this.termporalRestaurant,
        category: category != null ? category() : this.category,
      );
}
