import 'package:flutter/material.dart';
import 'package:fooddash/features/cart/models/cart_request.dart';
import 'package:fooddash/features/cart/models/cart_response.dart';
import 'package:fooddash/features/cart/services/cart_service.dart';
import 'package:fooddash/features/shared/models/loading_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier(ref);
});

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier(this.ref) : super(CartState());
  final StateNotifierProviderRef ref;

  initData() {
    state = state.copyWith(
      cartResponse: () => null,
      loading: LoadingStatus.none,
    );
  }

  Future<void> getMyCart() async {
    if (state.loading == LoadingStatus.loading) return;

    state = state.copyWith(
      loading: LoadingStatus.loading,
    );

    try {
      final CartResponse? response = await CartService.getMyCart();
      state = state.copyWith(
        cartResponse: () => response,
        loading: LoadingStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        loading: LoadingStatus.error,
      );
      rethrow;
    }
  }

  Future<void> deleteMyCart() async {
    if (state.loading == LoadingStatus.loading) return;

    state = state.copyWith(
      loading: LoadingStatus.loading,
    );

    try {
      await CartService.deleteMyCart();
      state = state.copyWith(
        cartResponse: () => null,
        loading: LoadingStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        loading: LoadingStatus.error,
      );
      rethrow;
    }
  }

  Future<void> addDishToCart(
    DishCartRequest dishCartRequest,
    int restaurantId,
  ) async {
    List<DishCartRequest> dishes = [dishCartRequest, ...state.dishesForRequest];

    CartRequest cartRequest = CartRequest(
      restaurantId: restaurantId,
      dishes: dishes,
    );

    updateCart(cartRequest);
  }

  updateCart(CartRequest cartRequest) async {
    try {
      state = state.copyWith(
        loading: LoadingStatus.loading,
      );
      final CartResponse response = await CartService.updateMyCart(cartRequest);
      state = state.copyWith(
        cartResponse: () => response,
        loading: LoadingStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        loading: LoadingStatus.error,
      );
      rethrow;
    }
  }

  addUnitDish(int dishId) {
    if (state.cartResponse == null) return;

    state = state.copyWith(
      cartResponse: () => state.cartResponse!.copyWith(
        dishCarts: state.cartResponse!.dishCarts.map((dishCart) {
          if (dishCart.id == dishId) {
            return dishCart.copyWith(units: dishCart.units + 1);
          }

          return dishCart;
        }).toList(),
      ),
    );

    CartRequest cartRequest = CartRequest(
      restaurantId: state.cartResponse!.restaurant.id,
      dishes: state.dishesForRequest,
    );

    updateCart(cartRequest);
  }

  removeUnitDish(int dishId) async {
    if (state.cartResponse == null) return;

    List<DishCart> dishCarts = state.cartResponse!.dishCarts.map((dishCart) {
      if (dishCart.id == dishId) {
        return dishCart.copyWith(units: dishCart.units - 1);
      }

      return dishCart;
    }).toList();

    dishCarts = dishCarts.where((dishCart) => dishCart.units > 0).toList();

    state = state.copyWith(
      cartResponse: () => state.cartResponse!.copyWith(
        dishCarts: dishCarts,
      ),
    );

    if (dishCarts.isEmpty) {
      await deleteMyCart();
      return;
    }

    CartRequest cartRequest = CartRequest(
      restaurantId: state.cartResponse!.restaurant.id,
      dishes: state.dishesForRequest,
    );

    updateCart(cartRequest);
  }
}

class CartState {
  final CartResponse? cartResponse;
  final LoadingStatus loading;

  int? get numDishes {
    if (cartResponse != null) {
      if (cartResponse!.dishCarts.isNotEmpty) {
        return cartResponse!.dishCarts
            .map((e) => e.units)
            .toList()
            .reduce((value, element) => value + element);
      }
      return 0;
    } else if (loading == LoadingStatus.success) {
      return 0;
    }

    return null;
  }

  List<DishCartRequest> get dishesForRequest {
    if (cartResponse == null) return [];

    List<DishCartRequest> dishes = [];

    for (var dishCart in cartResponse!.dishCarts) {
      dishes.add(
        DishCartRequest(
          dishId: dishCart.id,
          units: dishCart.units,
          toppings: dishCart.toppingDishCarts
              .map(
                (toppingDishCart) => ToppingDishCartRequest(
                  toppingId: toppingDishCart.id,
                  units: toppingDishCart.units,
                ),
              )
              .toList(),
        ),
      );
    }

    return dishes;
  }

  CartState({
    this.cartResponse,
    this.loading = LoadingStatus.none,
  });

  CartState copyWith({
    ValueGetter<CartResponse?>? cartResponse,
    LoadingStatus? loading,
  }) =>
      CartState(
        cartResponse: cartResponse != null ? cartResponse() : this.cartResponse,
        loading: loading ?? this.loading,
      );
}
