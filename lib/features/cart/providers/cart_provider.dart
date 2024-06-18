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
      final CartResponse response = await CartService.getMyCart();
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

  Future<void> addDishToCart(
      DishCartRequest dishCartRequest, int restaurantId) async {
    state = state.copyWith(
      loading: LoadingStatus.loading,
    );

    CartRequest cartRequest = CartRequest(
      restaurantId: restaurantId,
      dishes: [
        dishCartRequest,
      ],
    );

    try {
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
}

class CartState {
  final CartResponse? cartResponse;
  final LoadingStatus loading;

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
