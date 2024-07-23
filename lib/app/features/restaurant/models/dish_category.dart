class DishCategory {
  final int id;
  final String name;
  final List<Dish> dishes;

  DishCategory({
    required this.id,
    required this.name,
    required this.dishes,
  });

  factory DishCategory.fromJson(Map<String, dynamic> json) => DishCategory(
        id: json["id"],
        name: json["name"],
        dishes: List<Dish>.from(json["dishes"].map((x) => Dish.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "dishes": List<dynamic>.from(dishes.map((x) => x.toJson())),
      };
}

class Dish {
  final int id;
  final String name;
  final String image;
  final String description;
  final double price;
  final int stock;

  Dish({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.stock,
  });

  factory Dish.fromJson(Map<String, dynamic> json) => Dish(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        stock: json["stock"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "price": price,
        "stock": stock,
      };
}
