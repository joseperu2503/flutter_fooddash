class CartResponse {
  final int id;
  final List<DishCart> dishCarts;
  final Restaurant restaurant;

  CartResponse({
    required this.id,
    required this.dishCarts,
    required this.restaurant,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
        id: json["id"],
        dishCarts: List<DishCart>.from(
            json["dishCarts"].map((x) => DishCart.fromJson(x))),
        restaurant: Restaurant.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dishCarts": List<dynamic>.from(dishCarts.map((x) => x.toJson())),
        "restaurant": restaurant.toJson(),
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

class Restaurant {
  final int id;
  final String name;
  final String address;
  final String logo;
  final String backdrop;
  final double latitude;
  final double longitude;
  final bool isActive;
  final String openTime;
  final String closeTime;
  final DateTime createdAt;
  final DateTime updatedAt;

  Restaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.logo,
    required this.backdrop,
    required this.latitude,
    required this.longitude,
    required this.isActive,
    required this.openTime,
    required this.closeTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        logo: json["logo"],
        backdrop: json["backdrop"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        isActive: json["isActive"],
        openTime: json["openTime"],
        closeTime: json["closeTime"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "logo": logo,
        "backdrop": backdrop,
        "latitude": latitude,
        "longitude": longitude,
        "isActive": isActive,
        "openTime": openTime,
        "closeTime": closeTime,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
