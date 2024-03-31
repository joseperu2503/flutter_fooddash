class DishCategory {
  final String name;
  final List<Dish> dishes;

  DishCategory({
    required this.name,
    required this.dishes,
  });

  factory DishCategory.fromJson(Map<String, dynamic> json) => DishCategory(
        name: json["name"],
        dishes: List<Dish>.from(json["dishes"].map((x) => Dish.fromJson(x))),
      );
}

class Dish {
  final String name;
  final double price;
  final String description;
  final String image;

  Dish({
    required this.name,
    required this.price,
    required this.description,
    required this.image,
  });

  factory Dish.fromJson(Map<String, dynamic> json) => Dish(
        name: json["name"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        image: json["image"],
      );
}
