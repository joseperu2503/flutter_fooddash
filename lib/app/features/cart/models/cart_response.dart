class CartResponse {
  final bool success;
  final Cart? data;

  CartResponse({
    required this.success,
    required this.data,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
        success: json["success"],
        data: json["data"] == null ? null : Cart.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class Cart {
  final int id;
  final double subtotal;
  final Restaurant restaurant;
  final Address address;
  final List<Dish> dishes;

  Cart({
    required this.id,
    required this.subtotal,
    required this.restaurant,
    required this.address,
    required this.dishes,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        subtotal: json["subtotal"]?.toDouble(),
        restaurant: Restaurant.fromJson(json["restaurant"]),
        address: Address.fromJson(json["address"]),
        dishes: List<Dish>.from(json["dishes"].map((x) => Dish.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subtotal": subtotal,
        "restaurant": restaurant.toJson(),
        "address": address.toJson(),
        "dishes": List<dynamic>.from(dishes.map((x) => x.toJson())),
      };

  Cart copyWith({
    int? id,
    double? subtotal,
    Restaurant? restaurant,
    Address? address,
    List<Dish>? dishes,
  }) {
    return Cart(
      id: id ?? this.id,
      subtotal: subtotal ?? this.subtotal,
      restaurant: restaurant ?? this.restaurant,
      address: address ?? this.address,
      dishes: dishes ?? this.dishes,
    );
  }
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

class Dish {
  final int id;
  final String name;
  final String image;
  final String description;
  final double price;
  final int units;
  final List<Topping> toppings;

  Dish({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.units,
    required this.toppings,
  });

  factory Dish.fromJson(Map<String, dynamic> json) => Dish(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        units: json["units"],
        toppings: List<Topping>.from(
            json["toppings"].map((x) => Topping.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "price": price,
        "units": units,
        "toppings": List<dynamic>.from(toppings.map((x) => x.toJson())),
      };

  Dish copyWith({
    int? id,
    String? name,
    String? image,
    String? description,
    double? price,
    int? units,
    List<Topping>? toppings,
  }) {
    return Dish(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      price: price ?? this.price,
      units: units ?? this.units,
      toppings: toppings ?? this.toppings,
    );
  }
}

class Topping {
  final int id;
  final String description;
  final int price;
  final int units;

  Topping({
    required this.id,
    required this.description,
    required this.price,
    required this.units,
  });

  factory Topping.fromJson(Map<String, dynamic> json) => Topping(
        id: json["id"],
        description: json["description"],
        price: json["price"],
        units: json["units"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "price": price,
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

  Restaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.logo,
    required this.backdrop,
    required this.latitude,
    required this.longitude,
  });

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
