class DishDetail {
  final int id;
  final String name;
  final String image;
  final String description;
  final double price;
  final int stock;
  final bool isActive;
  final DishCategory? dishCategory;
  final List<ToppingCategory> toppingCategories;

  DishDetail({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.stock,
    required this.isActive,
    required this.dishCategory,
    required this.toppingCategories,
  });

  factory DishDetail.fromJson(Map<String, dynamic> json) => DishDetail(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        stock: json["stock"],
        isActive: json["isActive"],
        dishCategory: json["dishCategory"] == null
            ? null
            : DishCategory.fromJson(json["dishCategory"]),
        toppingCategories: List<ToppingCategory>.from(
            json["toppingCategories"].map((x) => ToppingCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "price": price,
        "stock": stock,
        "isActive": isActive,
        "dishCategory": dishCategory?.toJson(),
        "toppingCategories":
            List<dynamic>.from(toppingCategories.map((x) => x.toJson())),
      };
}

class DishCategory {
  final int id;
  final String name;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Restaurant restaurant;

  DishCategory({
    required this.id,
    required this.name,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.restaurant,
  });

  factory DishCategory.fromJson(Map<String, dynamic> json) => DishCategory(
        id: json["id"],
        name: json["name"],
        isActive: json["isActive"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        restaurant: Restaurant.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "isActive": isActive,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "restaurant": restaurant.toJson(),
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

class ToppingCategory {
  final int id;
  final String description;
  final bool isActive;
  final int maxToppings;
  final int minToppings;
  final String subtitle;
  final List<Topping> toppings;

  ToppingCategory({
    required this.id,
    required this.description,
    required this.isActive,
    required this.maxToppings,
    required this.minToppings,
    required this.subtitle,
    required this.toppings,
  });

  factory ToppingCategory.fromJson(Map<String, dynamic> json) =>
      ToppingCategory(
        id: json["id"],
        description: json["description"],
        isActive: json["isActive"],
        maxToppings: json["maxToppings"],
        minToppings: json["minToppings"],
        subtitle: json["subtitle"],
        toppings: List<Topping>.from(
            json["toppings"].map((x) => Topping.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "isActive": isActive,
        "maxToppings": maxToppings,
        "minToppings": minToppings,
        "subtitle": subtitle,
        "toppings": List<dynamic>.from(toppings.map((x) => x.toJson())),
      };
}

class Topping {
  final int id;
  final String description;
  final bool isActive;
  final int maxLimit;
  final double price;

  Topping({
    required this.id,
    required this.description,
    required this.isActive,
    required this.maxLimit,
    required this.price,
  });

  factory Topping.fromJson(Map<String, dynamic> json) => Topping(
        id: json["id"],
        description: json["description"],
        isActive: json["isActive"],
        maxLimit: json["maxLimit"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "isActive": isActive,
        "maxLimit": maxLimit,
        "price": price,
      };
}
