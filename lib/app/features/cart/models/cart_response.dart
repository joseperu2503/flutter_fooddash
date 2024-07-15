class CartResponse {
  final int id;
  final double subtotal;
  final double deliveryFee;
  final double serviceFee;
  final double total;
  final List<DishCart> dishCarts;
  final Restaurant restaurant;
  final Address address;

  CartResponse({
    required this.id,
    required this.subtotal,
    required this.deliveryFee,
    required this.serviceFee,
    required this.total,
    required this.dishCarts,
    required this.restaurant,
    required this.address,
  });

  CartResponse copyWith({
    int? id,
    double? subtotal,
    double? deliveryFee,
    double? serviceFee,
    double? total,
    List<DishCart>? dishCarts,
    Restaurant? restaurant,
    Address? address,
  }) =>
      CartResponse(
        id: id ?? this.id,
        subtotal: subtotal ?? this.subtotal,
        deliveryFee: deliveryFee ?? this.deliveryFee,
        serviceFee: serviceFee ?? this.serviceFee,
        total: total ?? this.total,
        dishCarts: dishCarts ?? this.dishCarts,
        restaurant: restaurant ?? this.restaurant,
        address: address ?? this.address,
      );

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
        id: json["id"],
        subtotal: json["subtotal"]?.toDouble(),
        deliveryFee: json["deliveryFee"]?.toDouble(),
        serviceFee: json["serviceFee"]?.toDouble(),
        total: json["total"]?.toDouble(),
        dishCarts: List<DishCart>.from(
            json["dishCarts"].map((x) => DishCart.fromJson(x))),
        restaurant: Restaurant.fromJson(json["restaurant"]),
        address: Address.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subtotal": subtotal,
        "deliveryFee": deliveryFee,
        "serviceFee": serviceFee,
        "total": total,
        "dishCarts": List<dynamic>.from(dishCarts.map((x) => x.toJson())),
        "restaurant": restaurant.toJson(),
        "address": address.toJson(),
      };
}

class Address {
  final int id;
  final String address;
  final double latitude;
  final double longitude;

  Address({
    required this.id,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  Address copyWith({
    int? id,
    String? address,
    double? latitude,
    double? longitude,
  }) =>
      Address(
        id: id ?? this.id,
        address: address ?? this.address,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        address: json["address"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
      };
}

class DishCart {
  final int id;
  final int units;
  final Dish dish;
  final List<dynamic> toppingDishCarts;

  DishCart({
    required this.id,
    required this.units,
    required this.dish,
    required this.toppingDishCarts,
  });

  DishCart copyWith({
    int? id,
    int? units,
    Dish? dish,
    List<dynamic>? toppingDishCarts,
  }) =>
      DishCart(
        id: id ?? this.id,
        units: units ?? this.units,
        dish: dish ?? this.dish,
        toppingDishCarts: toppingDishCarts ?? this.toppingDishCarts,
      );

  factory DishCart.fromJson(Map<String, dynamic> json) => DishCart(
        id: json["id"],
        units: json["units"],
        dish: Dish.fromJson(json["dish"]),
        toppingDishCarts:
            List<dynamic>.from(json["toppingDishCarts"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "units": units,
        "dish": dish.toJson(),
        "toppingDishCarts": List<dynamic>.from(toppingDishCarts.map((x) => x)),
      };
}

class Dish {
  final int id;
  final String name;
  final String image;
  final String description;
  final double price;

  Dish({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
  });

  Dish copyWith({
    int? id,
    String? name,
    String? image,
    String? description,
    double? price,
  }) =>
      Dish(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        description: description ?? this.description,
        price: price ?? this.price,
      );

  factory Dish.fromJson(Map<String, dynamic> json) => Dish(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "price": price,
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

  Restaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.logo,
    required this.backdrop,
    required this.latitude,
    required this.longitude,
  });

  Restaurant copyWith({
    int? id,
    String? name,
    String? address,
    String? logo,
    String? backdrop,
    double? latitude,
    double? longitude,
  }) =>
      Restaurant(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
        logo: logo ?? this.logo,
        backdrop: backdrop ?? this.backdrop,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        logo: json["logo"],
        backdrop: json["backdrop"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "logo": logo,
        "backdrop": backdrop,
        "latitude": latitude,
        "longitude": longitude,
      };
}
