class Dish {
  final int id;
  final String name;
  final String image;
  final String description;
  final double price;
  final int stock;
  final DishCategory? dishCategory;
  final bool? isFavorite;

  Dish({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.stock,
    this.dishCategory,
    this.isFavorite,
  });

  factory Dish.fromJson(Map<String, dynamic> json) => Dish(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        stock: json["stock"],
        dishCategory: json["dishCategory"] == null
            ? null
            : DishCategory.fromJson(json["dishCategory"]),
        isFavorite: json["isFavorite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "price": price,
        "stock": stock,
        "dishCategory": dishCategory?.toJson(),
        "isFavorite": isFavorite,
      };
}

class DishCategory {
  final int id;
  final String name;
  final Restaurant restaurant;

  DishCategory({
    required this.id,
    required this.name,
    required this.restaurant,
  });

  factory DishCategory.fromJson(Map<String, dynamic> json) => DishCategory(
        id: json["id"],
        name: json["name"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "restaurant": restaurant.toJson(),
      };
}

class Restaurant {
  final int id;
  final String name;

  Restaurant({
    required this.id,
    required this.name,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
