class CartRequest {
  final int restaurantId;
  final List<DishCartRequest> dishes;

  CartRequest({
    required this.restaurantId,
    required this.dishes,
  });

  factory CartRequest.fromJson(Map<String, dynamic> json) => CartRequest(
        restaurantId: json["restaurantId"],
        dishes: List<DishCartRequest>.from(
            json["dishes"].map((x) => DishCartRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "restaurantId": restaurantId,
        "dishes": List<dynamic>.from(dishes.map((x) => x.toJson())),
      };
}

class DishCartRequest {
  final int dishId;
  final int units;
  final List<ToppingDishCartRequest> toppings;

  DishCartRequest({
    required this.dishId,
    required this.units,
    required this.toppings,
  });

  factory DishCartRequest.fromJson(Map<String, dynamic> json) =>
      DishCartRequest(
        dishId: json["dishId"],
        units: json["units"],
        toppings: List<ToppingDishCartRequest>.from(
            json["toppings"].map((x) => ToppingDishCartRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dishId": dishId,
        "units": units,
        "toppings": List<dynamic>.from(toppings.map((x) => x.toJson())),
      };
}

class ToppingDishCartRequest {
  final int toppingId;
  final int units;

  ToppingDishCartRequest({
    required this.toppingId,
    required this.units,
  });

  factory ToppingDishCartRequest.fromJson(Map<String, dynamic> json) =>
      ToppingDishCartRequest(
        toppingId: json["toppingId"],
        units: json["units"],
      );

  Map<String, dynamic> toJson() => {
        "toppingId": toppingId,
        "units": units,
      };
}
