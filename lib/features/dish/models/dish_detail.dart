class DishDetail {
  final int id;
  final String name;
  final String image;
  final String description;
  final double price;
  final int stock;
  final bool isActive;
  final List<ToppingCategory> toppingCategories;

  DishDetail({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.stock,
    required this.isActive,
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
        "toppingCategories":
            List<dynamic>.from(toppingCategories.map((x) => x.toJson())),
      };
}

class ToppingCategory {
  final int id;
  final String description;
  final bool isActive;
  final int maxToppings;
  final int minToppings;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Topping> toppings;

  ToppingCategory({
    required this.id,
    required this.description,
    required this.isActive,
    required this.maxToppings,
    required this.minToppings,
    required this.createdAt,
    required this.updatedAt,
    required this.toppings,
  });

  factory ToppingCategory.fromJson(Map<String, dynamic> json) =>
      ToppingCategory(
        id: json["id"],
        description: json["description"],
        isActive: json["isActive"],
        maxToppings: json["maxToppings"],
        minToppings: json["minToppings"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        toppings: List<Topping>.from(
            json["toppings"].map((x) => Topping.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "isActive": isActive,
        "maxToppings": maxToppings,
        "minToppings": minToppings,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "toppings": List<dynamic>.from(toppings.map((x) => x.toJson())),
      };
}

class Topping {
  final int id;
  final String description;
  final bool isActive;
  final int maxLimit;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;

  Topping({
    required this.id,
    required this.description,
    required this.isActive,
    required this.maxLimit,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Topping.fromJson(Map<String, dynamic> json) => Topping(
        id: json["id"],
        description: json["description"],
        isActive: json["isActive"],
        maxLimit: json["maxLimit"],
        price: json["price"]?.toDouble(),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "isActive": isActive,
        "maxLimit": maxLimit,
        "price": price,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
