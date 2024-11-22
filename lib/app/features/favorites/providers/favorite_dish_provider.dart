import 'package:fooddash/app/features/core/models/service_exception.dart';
import 'package:fooddash/app/features/dish/models/dish.dart';
import 'package:fooddash/app/features/dish/models/dishes_response.dart';
import 'package:fooddash/app/features/dish/providers/dish_provider.dart';
import 'package:fooddash/app/features/dish/services/dish_service.dart';
import 'package:fooddash/app/features/shared/models/loading_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/features/shared/services/snackbar_service.dart';

final favoriteDishProvider =
    StateNotifierProvider<FavoriteDishNotifier, FavoriteDishState>((ref) {
  return FavoriteDishNotifier(ref);
});

class FavoriteDishNotifier extends StateNotifier<FavoriteDishState> {
  FavoriteDishNotifier(this.ref) : super(FavoriteDishState());
  final Ref ref;

  void initData() {
    state = state.copyWith(
      dishes: [],
      page: 1,
      totalPages: 1,
      loadingStatus: LoadingStatus.none,
    );
  }

  Future<void> getDishes() async {
    if (state.page > state.totalPages ||
        state.loadingStatus == LoadingStatus.loading) return;

    state = state.copyWith(
      loadingStatus: LoadingStatus.loading,
    );

    try {
      final DishesResponse response = await DishService.getFavorites(
        page: state.page,
      );
      state = state.copyWith(
        dishes: [...state.dishes, ...response.items],
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

  toggleFavorite({required int dishId}) async {
    try {
      final Dish dish = await DishService.toggleFavorite(dishId: dishId);

      ref.read(dishProvider.notifier).setDish(dish);

      initData();
      getDishes();
    } on ServiceException catch (e) {
      SnackBarService.show(e.message);
    }
  }
}

class FavoriteDishState {
  final List<Dish> dishes;
  final int page;
  final int totalPages;
  final LoadingStatus loadingStatus;

  FavoriteDishState({
    this.dishes = const [],
    this.page = 1,
    this.totalPages = 1,
    this.loadingStatus = LoadingStatus.none,
  });

  FavoriteDishState copyWith({
    List<Dish>? dishes,
    int? page,
    int? totalPages,
    LoadingStatus? loadingStatus,
  }) =>
      FavoriteDishState(
        dishes: dishes ?? this.dishes,
        page: page ?? this.page,
        totalPages: totalPages ?? this.totalPages,
        loadingStatus: loadingStatus ?? this.loadingStatus,
      );
}
