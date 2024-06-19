import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  DishCartRequest copyWith({
    int? dishId,
    int? units,
    List<ToppingDishCartRequest>? toppings,
  }) {
    return DishCartRequest(
      dishId: dishId ?? this.dishId,
      units: units ?? this.units,
      toppings: toppings ?? this.toppings,
    );
  }

  @override
  bool operator ==(covariant DishCartRequest other) {
    if (identical(this, other)) return true;

    return other.dishId == dishId && listEquals(other.toppings, toppings);
  }

  @override
  int get hashCode => dishId.hashCode ^ toppings.hashCode;
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

  @override
  bool operator ==(covariant ToppingDishCartRequest other) {
    if (identical(this, other)) return true;

    return other.toppingId == toppingId && other.units == units;
  }

  @override
  int get hashCode => toppingId.hashCode ^ units.hashCode;
}
