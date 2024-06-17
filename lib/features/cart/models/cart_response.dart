class CartResponse {
  final int id;
  final List<DishCart> dishCarts;

  CartResponse({
    required this.id,
    required this.dishCarts,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
        id: json["id"],
        dishCarts: List<DishCart>.from(
            json["dishCarts"].map((x) => DishCart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dishCarts": List<dynamic>.from(dishCarts.map((x) => x.toJson())),
      };
}

class DishCart {
  final int id;
  final String name;
  final String image;
  final String description;
  final double price;
  final int stock;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int units;
  final List<ToppingDishCart> toppingDishCarts;

  DishCart({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.stock,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.units,
    required this.toppingDishCarts,
  });

  factory DishCart.fromJson(Map<String, dynamic> json) => DishCart(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        stock: json["stock"],
        isActive: json["isActive"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        units: json["units"],
        toppingDishCarts: List<ToppingDishCart>.from(
            json["toppingDishCarts"].map((x) => ToppingDishCart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "price": price,
        "stock": stock,
        "isActive": isActive,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "units": units,
        "toppingDishCarts":
            List<dynamic>.from(toppingDishCarts.map((x) => x.toJson())),
      };
}

class ToppingDishCart {
  final int id;
  final String description;
  final bool isActive;
  final int maxLimit;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int units;

  ToppingDishCart({
    required this.id,
    required this.description,
    required this.isActive,
    required this.maxLimit,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.units,
  });

  factory ToppingDishCart.fromJson(Map<String, dynamic> json) =>
      ToppingDishCart(
        id: json["id"],
        description: json["description"],
        isActive: json["isActive"],
        maxLimit: json["maxLimit"],
        price: json["price"]?.toDouble(),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        units: json["units"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "isActive": isActive,
        "maxLimit": maxLimit,
        "price": price,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "units": units,
      };
}
