import 'package:fooddash/features/dish/models/dish_detail.dart';
import 'package:fooddash/features/restaurant/models/restaurant_detail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dishProvider = StateNotifierProvider<DishNotifier, DishState>((ref) {
  return DishNotifier(ref);
});

class DishNotifier extends StateNotifier<DishState> {
  DishNotifier(this.ref) : super(DishState());
  final StateNotifierProviderRef ref;

  setTemporalDish(Dish dish) async {
    state = state.copyWith(
      termporalDish: DishDetail(
        id: dish.id,
        name: dish.name,
        image: dish.image,
        description: dish.description,
        price: dish.price,
        stock: dish.stock,
        isActive: dish.isActive,
      ),
    );
  }
}

class DishState {
  final DishDetail? termporalDish;

  DishState({
    this.termporalDish,
  });

  DishState copyWith({
    DishDetail? termporalDish,
  }) =>
      DishState(
        termporalDish: termporalDish ?? this.termporalDish,
      );
}
