import 'package:fooddash/app/features/dish/models/dish.dart';

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
