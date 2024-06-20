import 'package:flutter/material.dart';
import 'package:fooddash/config/router/app_router.dart';
import 'package:fooddash/features/cart/models/cart_request.dart';
import 'package:fooddash/features/cart/models/cart_response.dart';
import 'package:fooddash/features/cart/services/cart_service.dart';
import 'package:fooddash/features/cart/widgets/change_order.dart';
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
    final int dishForRequestIndex = state.dishesForRequest
        .indexWhere((dishForRequest) => dishForRequest == dishCartRequest);

    if (dishForRequestIndex >= 0) {
      //cuando el plato que se va a agregar ya esta en el cart
      await addUnitDish(dishForRequestIndex);
      return;
    }

    List<DishCartRequest> dishes = [];
    if (restaurantId == state.cartResponse?.restaurant.id) {
      //cuando el plato que se va a agregar pertenece al restaurant del cart
      dishes = [dishCartRequest, ...state.dishesForRequest];
    } else {
      //cuando el plato que se va a agregar no pertenece al restaurant del cart
      if (rootNavigatorKey.currentContext == null) return;
      bool? response = await showModalBottomSheet(
        context: rootNavigatorKey.currentContext!,
        elevation: 0,
        builder: (context) {
          return const ChangeOrder();
        },
      );
      if (response == null) {
        return;
      }
      if (response == false) {
        appRouter.push('/cart');
        return;
      }

      dishes = [dishCartRequest];
    }

    CartRequest cartRequest = CartRequest(
      restaurantId: restaurantId,
      dishes: dishes,
    );

    await updateCart(cartRequest);
  }

  Future<void> updateCart(CartRequest cartRequest) async {
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

  Future<void> addUnitDish(int index) async {
    if (state.cartResponse == null) return;

    state = state.copyWith(
      cartResponse: () => state.cartResponse!.copyWith(
        dishCarts: state.cartResponse!.dishCarts.map((dishCart) {
          if (state.cartResponse!.dishCarts.indexOf(dishCart) == index) {
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

    await updateCart(cartRequest);
  }

  Future<void> removeUnitDish(int index) async {
    if (state.cartResponse == null) return;

    List<DishCart> dishCarts = state.cartResponse!.dishCarts.map((dishCart) {
      if (state.cartResponse!.dishCarts.indexOf(dishCart) == index) {
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
