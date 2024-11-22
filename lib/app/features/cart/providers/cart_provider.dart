import 'package:flutter/material.dart';
import 'package:fooddash/app/config/router/app_router.dart';
import 'package:fooddash/app/features/address/providers/address_provider.dart';
import 'package:fooddash/app/features/cart/models/cart_request.dart';
import 'package:fooddash/app/features/cart/models/cart_response.dart';
import 'package:fooddash/app/features/cart/services/cart_service.dart';
import 'package:fooddash/app/features/cart/widgets/change_order.dart';
import 'package:fooddash/app/features/core/models/service_exception.dart';
import 'package:fooddash/app/features/order/models/order_request.dart';
import 'package:fooddash/app/features/shared/models/loading_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooddash/app/features/shared/services/snackbar_service.dart';

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier(ref);
});

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier(this.ref) : super(CartState());
  final Ref ref;

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
    final addressId = getAddres();
    if (addressId == null) return;

    try {
      final int dishForRequestIndex = state.dishesForCartRequest
          .indexWhere((dishForRequest) => dishForRequest == dishCartRequest);

      if (dishForRequestIndex >= 0) {
        //cuando el plato que se va a agregar ya esta en el cart
        await addUnitDish(dishForRequestIndex);
        return;
      }

      List<DishCartRequest> dishes = [];
      if (restaurantId == state.cartResponse?.restaurant.id ||
          state.cartResponse == null) {
        //cuando el plato que se va a agregar pertenece al restaurant del cart
        dishes = [dishCartRequest, ...state.dishesForCartRequest];
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
        addressId: addressId,
      );
      await updateCart(cartRequest);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateCart(CartRequest cartRequest) async {
    try {
      state = state.copyWith(
        loading: LoadingStatus.loading,
      );
      final CartResponse? response =
          await CartService.updateMyCart(cartRequest);
      state = state.copyWith(
        cartResponse: () => response,
        loading: LoadingStatus.success,
      );
    } on ServiceException catch (e) {
      state = state.copyWith(
        loading: LoadingStatus.error,
      );
      SnackBarService.show(e.message);

      rethrow;
    }
  }

  Future<void> addUnitDish(int index) async {
    if (state.cartResponse == null) return;
    final addressId = getAddres();
    if (addressId == null) return;

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
      dishes: state.dishesForCartRequest,
      addressId: addressId,
    );

    await updateCart(cartRequest);
  }

  Future<void> removeUnitDish(int index) async {
    if (state.cartResponse == null) return;
    final addressId = getAddres();
    if (addressId == null) return;

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
      dishes: state.dishesForCartRequest,
      addressId: addressId,
    );

    updateCart(cartRequest);
  }

  int? getAddres() {
    if (state.cartResponse != null) {
      return state.cartResponse!.address.id;
    }
    final selectedAddress = ref.read(addressProvider).selectedAddress;

    if (selectedAddress != null) {
      return selectedAddress.id;
    }
    return null;
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

  List<DishCartRequest> get dishesForCartRequest {
    if (cartResponse == null) return [];

    List<DishCartRequest> dishes = [];

    for (var dishCart in cartResponse!.dishCarts) {
      dishes.add(
        DishCartRequest(
          dishId: dishCart.dish.id,
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

  List<DishOrderRequest> get dishesForOrderRequest {
    if (cartResponse == null) return [];

    List<DishOrderRequest> dishes = [];

    for (var dishCart in cartResponse!.dishCarts) {
      dishes.add(
        DishOrderRequest(
          dishId: dishCart.dish.id,
          units: dishCart.units,
          toppings: dishCart.toppingDishCarts
              .map(
                (toppingDishCart) => ToppingDishOrderRequest(
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
