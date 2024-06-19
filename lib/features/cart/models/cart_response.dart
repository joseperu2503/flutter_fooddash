class CartResponse {
  final int id;
  final List<DishCart> dishCarts;
  final Restaurant restaurant;
  final double subtotal;

  CartResponse({
    required this.id,
    required this.dishCarts,
    required this.restaurant,
    required this.subtotal,
  });

  CartResponse copyWith({
    int? id,
    List<DishCart>? dishCarts,
    Restaurant? restaurant,
    double? subtotal,
  }) =>
      CartResponse(
        id: id ?? this.id,
        dishCarts: dishCarts ?? this.dishCarts,
        restaurant: restaurant ?? this.restaurant,
        subtotal: subtotal ?? this.subtotal,
      );

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
        id: json["id"],
        dishCarts: List<DishCart>.from(
            json["dishCarts"].map((x) => DishCart.fromJson(x))),
        restaurant: Restaurant.fromJson(json["restaurant"]),
        subtotal: json["subtotal"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dishCarts": List<dynamic>.from(dishCarts.map((x) => x.toJson())),
        "restaurant": restaurant.toJson(),
        "subtotal": subtotal,
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

  DishCart copyWith({
    int? id,
    String? name,
    String? image,
    String? description,
    double? price,
    int? stock,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? units,
    List<ToppingDishCart>? toppingDishCarts,
  }) =>
      DishCart(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        description: description ?? this.description,
        price: price ?? this.price,
        stock: stock ?? this.stock,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        units: units ?? this.units,
        toppingDishCarts: toppingDishCarts ?? this.toppingDishCarts,
      );

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

  ToppingDishCart copyWith({
    int? id,
    String? description,
    bool? isActive,
    int? maxLimit,
    double? price,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? units,
  }) =>
      ToppingDishCart(
        id: id ?? this.id,
        description: description ?? this.description,
        isActive: isActive ?? this.isActive,
        maxLimit: maxLimit ?? this.maxLimit,
        price: price ?? this.price,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        units: units ?? this.units,
      );

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

  Restaurant copyWith({
    int? id,
    String? name,
    String? address,
    String? logo,
    String? backdrop,
    double? latitude,
    double? longitude,
    bool? isActive,
    String? openTime,
    String? closeTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Restaurant(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
        logo: logo ?? this.logo,
        backdrop: backdrop ?? this.backdrop,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        isActive: isActive ?? this.isActive,
        openTime: openTime ?? this.openTime,
        closeTime: closeTime ?? this.closeTime,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

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
