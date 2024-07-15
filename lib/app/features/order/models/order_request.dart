class OrderRequest {
  final int restaurantId;
  final List<DishOrderRequest> dishes;
  final int addressId;
  final String paymentMethodId;

  OrderRequest({
    required this.restaurantId,
    required this.dishes,
    required this.addressId,
    required this.paymentMethodId,
  });

  factory OrderRequest.fromJson(Map<String, dynamic> json) => OrderRequest(
        restaurantId: json["restaurantId"],
        dishes: List<DishOrderRequest>.from(
            json["dishes"].map((x) => DishOrderRequest.fromJson(x))),
        addressId: json["addressId"],
        paymentMethodId: json["paymentMethodId"],
      );

  Map<String, dynamic> toJson() => {
        "restaurantId": restaurantId,
        "dishes": List<dynamic>.from(dishes.map((x) => x.toJson())),
        "addressId": addressId,
        "paymentMethodId": paymentMethodId,
      };
}

class DishOrderRequest {
  final int dishId;
  final int units;
  final List<ToppingDishOrderRequest> toppings;

  DishOrderRequest({
    required this.dishId,
    required this.units,
    required this.toppings,
  });

  factory DishOrderRequest.fromJson(Map<String, dynamic> json) =>
      DishOrderRequest(
        dishId: json["dishId"],
        units: json["units"],
        toppings: List<ToppingDishOrderRequest>.from(
            json["toppings"].map((x) => ToppingDishOrderRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dishId": dishId,
        "units": units,
        "toppings": List<dynamic>.from(toppings.map((x) => x.toJson())),
      };

  DishOrderRequest copyWith({
    int? dishId,
    int? units,
    List<ToppingDishOrderRequest>? toppings,
  }) {
    return DishOrderRequest(
      dishId: dishId ?? this.dishId,
      units: units ?? this.units,
      toppings: toppings ?? this.toppings,
    );
  }
}

class ToppingDishOrderRequest {
  final int toppingId;
  final int units;

  ToppingDishOrderRequest({
    required this.toppingId,
    required this.units,
  });

  factory ToppingDishOrderRequest.fromJson(Map<String, dynamic> json) =>
      ToppingDishOrderRequest(
        toppingId: json["toppingId"],
        units: json["units"],
      );

  Map<String, dynamic> toJson() => {
        "toppingId": toppingId,
        "units": units,
      };
}
