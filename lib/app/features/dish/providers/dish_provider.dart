import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/config/router/app_router.dart';
import 'package:fooddash/app/features/cart/models/cart_request.dart';
import 'package:fooddash/app/features/cart/providers/cart_provider.dart';
import 'package:fooddash/app/features/dish/models/dish.dart';
import 'package:fooddash/app/features/dish/models/topping_category.dart';
import 'package:fooddash/app/features/dish/services/dish_service.dart';
import 'package:fooddash/app/features/shared/models/loading_status.dart';

final dishProvider = StateNotifierProvider<DishNotifier, DishState>((ref) {
  return DishNotifier(ref);
});

class DishNotifier extends StateNotifier<DishState> {
  DishNotifier(this.ref) : super(DishState());
  final StateNotifierProviderRef ref;

  setDish(Dish dish) async {
    state = state.copyWith(
      dish: dish,
    );
  }

  getDish(String dishId) async {
    state = state.copyWith(
      loading: LoadingStatus.loading,
      selectedToppings: [],
      units: 1,
      toppingCategories: [],
    );

    try {
      final Dish dish = await DishService.getDish(
        dishId: dishId,
      );

      final List<ToppingCategory> toppingCategories =
          await DishService.getToppings(
        dishId: dishId,
      );

      state = state.copyWith(
        dish: dish,
        toppingCategories: toppingCategories,
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
    if (state.dish == null || state.dish?.dishCategory == null) {
      return;
    }

    state = state.copyWith(
      addingToCart: LoadingStatus.loading,
    );

    List<ToppingDishCartRequest> toppings = [];

    for (var selectedTopping in state.selectedToppings) {
      ToppingDishCartRequest toppingDishCart = ToppingDishCartRequest(
        toppingId: selectedTopping.toppingId,
        units: selectedTopping.units,
      );

      toppings.add(toppingDishCart);
    }

    DishCartRequest dishCart = DishCartRequest(
      dishId: state.dish!.id,
      units: state.units,
      toppings: toppings,
    );

    try {
      await ref.read(cartProvider.notifier).addDishToCart(
            dishCart,
            state.dish!.dishCategory!.restaurant.id,
          );
      appRouter.pop();

      state = state.copyWith(
        addingToCart: LoadingStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        addingToCart: LoadingStatus.error,
      );
    }
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
  final Dish? dish;
  final int units;
  final List<SelectedTopping> selectedToppings;
  final LoadingStatus loading;
  final LoadingStatus addingToCart;
  final List<ToppingCategory> toppingCategories;

  DishState({
    this.dish,
    this.units = 1,
    this.selectedToppings = const [],
    this.loading = LoadingStatus.none,
    this.addingToCart = LoadingStatus.none,
    this.toppingCategories = const [],
  });

  List<ToppingCategoryForm> get toppingCategoriesStatus {
    if (dish == null) return [];
    List<ToppingCategoryForm> statuses = [];

    for (ToppingCategory toppingCategory in toppingCategories) {
      statuses.add(
        ToppingCategoryForm(
          toppingCategory: toppingCategory,
          selectedToppings: selectedToppings,
        ),
      );
    }
    return statuses;
  }

  bool get isDone {
    if (dish == null) return false;
    if (loading == LoadingStatus.loading) return false;

    for (ToppingCategoryForm toppingCategoryForm in toppingCategoriesStatus) {
      if (toppingCategoryForm.isMandatory && !toppingCategoryForm.isDone) {
        return false;
      }
    }
    return true;
  }

  DishState copyWith({
    Dish? dish,
    int? units,
    List<SelectedTopping>? selectedToppings,
    LoadingStatus? loading,
    LoadingStatus? addingToCart,
    List<ToppingCategory>? toppingCategories,
  }) =>
      DishState(
        dish: dish ?? this.dish,
        units: units ?? this.units,
        selectedToppings: selectedToppings ?? this.selectedToppings,
        loading: loading ?? this.loading,
        addingToCart: addingToCart ?? this.addingToCart,
        toppingCategories: toppingCategories ?? this.toppingCategories,
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

class ToppingCategoryForm extends ToppingCategory {
  ToppingCategory toppingCategory;
  List<SelectedTopping> selectedToppings;

  int get numSelectedToppings {
    int num = 0;

    for (SelectedTopping selectedTopping in selectedToppings) {
      if (selectedTopping.toppingCategoryId == toppingCategory.id) {
        num = num + selectedTopping.units;
      }
    }
    return num;
  }

  bool get isMandatory => toppingCategory.minToppings > 0;
  bool get isDone => numSelectedToppings == toppingCategory.maxToppings;

  ToppingCategoryForm({
    required this.toppingCategory,
    required this.selectedToppings,
  }) : super(
          id: toppingCategory.id,
          description: toppingCategory.description,
          maxToppings: toppingCategory.maxToppings,
          minToppings: toppingCategory.minToppings,
          subtitle: toppingCategory.subtitle,
          toppings: toppingCategory.toppings,
        );
}
