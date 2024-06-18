// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/features/cart/models/cart_request.dart';
import 'package:fooddash/features/cart/providers/cart_provider.dart';
import 'package:fooddash/features/dish/models/dish_detail.dart';
import 'package:fooddash/features/dish/services/dish_service.dart';
import 'package:fooddash/features/restaurant/models/restaurant_detail.dart';
import 'package:fooddash/features/shared/models/loading_status.dart';

final dishProvider = StateNotifierProvider<DishNotifier, DishState>((ref) {
  return DishNotifier(ref);
});

class DishNotifier extends StateNotifier<DishState> {
  DishNotifier(this.ref) : super(DishState());
  final StateNotifierProviderRef ref;

  setTemporalDish(Dish dish) async {
    state = state.copyWith(
      dishDetail: DishDetail(
        id: dish.id,
        name: dish.name,
        image: dish.image,
        description: dish.description,
        price: dish.price,
        stock: dish.stock,
        isActive: dish.isActive,
        toppingCategories: [],
        dishCategory: null,
      ),
      units: 1,
    );
  }

  getDish(String dishId) async {
    state = state.copyWith(
      loading: LoadingStatus.loading,
    );

    try {
      final DishDetail response = await DishService.getDish(
        dishId: dishId,
      );

      state = state.copyWith(
        dishDetail: response,
        loading: LoadingStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        loading: LoadingStatus.error,
      );
      throw Exception(e);
    }
  }

  onPressTopping({
    required ToppingCategory toppingCategory,
    required Topping topping,
    required int newQuantity,
  }) {
    List<SelectedTopping> selectedToppings = [...state.selectedToppings];

    if (toppingCategory.maxToppings == 1) {
      final List<int> toppingIds =
          toppingCategory.toppings.map((topping) => topping.id).toList();

      selectedToppings.removeWhere(
          (selectedTopping) => toppingIds.contains(selectedTopping.toppingId));

      if (newQuantity == 1) {
        selectedToppings.add(SelectedTopping(
          toppingId: topping.id,
          toppingCategoryId: toppingCategory.id,
          units: 1,
        ));
      }
    } else {
      if (newQuantity < 0) return;
      if (newQuantity == 0) {
        final selectedToppingIndex = selectedToppings.indexWhere(
            (selectedTopping) => selectedTopping.toppingId == topping.id);
        selectedToppings.removeAt(selectedToppingIndex);
      } else if (newQuantity == 1) {
        final selectedToppingIndex = selectedToppings.indexWhere(
            (selectedTopping) => selectedTopping.toppingId == topping.id);
        if (selectedToppingIndex == -1) {
          selectedToppings.add(SelectedTopping(
            toppingCategoryId: toppingCategory.id,
            toppingId: topping.id,
            units: newQuantity,
          ));
        } else {
          selectedToppings[selectedToppingIndex] = SelectedTopping(
            toppingCategoryId: toppingCategory.id,
            toppingId: topping.id,
            units: newQuantity,
          );
        }
      } else {
        final selectedToppingIndex = selectedToppings.indexWhere(
            (selectedTopping) => selectedTopping.toppingId == topping.id);

        selectedToppings[selectedToppingIndex] = SelectedTopping(
          toppingCategoryId: toppingCategory.id,
          toppingId: topping.id,
          units: newQuantity,
        );
      }
    }

    state = state.copyWith(
      selectedToppings: selectedToppings,
    );
  }

  Future<void> addDishToCart() async {
    if (state.dishDetail == null || state.dishDetail?.dishCategory == null) {
      return;
    }

    List<ToppingDishCartRequest> toppings = [];

    for (var selectedTopping in state.selectedToppings) {
      ToppingDishCartRequest toppingDishCart = ToppingDishCartRequest(
        toppingId: selectedTopping.toppingId,
        units: selectedTopping.units,
      );

      toppings.add(toppingDishCart);
    }

    DishCartRequest dishCart = DishCartRequest(
      dishId: state.dishDetail!.id,
      units: state.units,
      toppings: toppings,
    );

    ref
        .read(cartProvider.notifier)
        .addDishToCart(dishCart, state.dishDetail!.dishCategory!.restaurant.id);
  }

  addUnits() {
    state = state.copyWith(
      units: state.units + 1,
    );
  }

  removeUnits() {
    if (state.units == 1) return;

    state = state.copyWith(
      units: state.units - 1,
    );
  }
}

class DishState {
  final DishDetail? dishDetail;
  final int units;
  final List<SelectedTopping> selectedToppings;
  final LoadingStatus loading;

  DishState({
    this.dishDetail,
    this.units = 1,
    this.selectedToppings = const [],
    this.loading = LoadingStatus.none,
  });

  DishState copyWith({
    DishDetail? dishDetail,
    int? units,
    List<SelectedTopping>? selectedToppings,
    LoadingStatus? loading,
  }) =>
      DishState(
        dishDetail: dishDetail ?? this.dishDetail,
        units: units ?? this.units,
        selectedToppings: selectedToppings ?? this.selectedToppings,
        loading: loading ?? this.loading,
      );
}

class SelectedTopping {
  int toppingId;
  int toppingCategoryId;
  int units;
  SelectedTopping({
    required this.toppingId,
    required this.toppingCategoryId,
    required this.units,
  });
}
