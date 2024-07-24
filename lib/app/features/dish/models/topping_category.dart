class ToppingCategory {
  final int id;
  final String description;
  final int maxToppings;
  final int minToppings;
  final String subtitle;
  final List<Topping> toppings;

  ToppingCategory({
    required this.id,
    required this.description,
    required this.maxToppings,
    required this.minToppings,
    required this.subtitle,
    required this.toppings,
  });

  factory ToppingCategory.fromJson(Map<String, dynamic> json) =>
      ToppingCategory(
        id: json["id"],
        description: json["description"],
        maxToppings: json["maxToppings"],
        minToppings: json["minToppings"],
        subtitle: json["subtitle"],
        toppings: List<Topping>.from(
            json["toppings"].map((x) => Topping.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "maxToppings": maxToppings,
        "minToppings": minToppings,
        "subtitle": subtitle,
        "toppings": List<dynamic>.from(toppings.map((x) => x.toJson())),
      };
}

class Topping {
  final int id;
  final String description;
  final int maxLimit;
  final double price;

  Topping({
    required this.id,
    required this.description,
    required this.maxLimit,
    required this.price,
  });

  factory Topping.fromJson(Map<String, dynamic> json) => Topping(
        id: json["id"],
        description: json["description"],
        maxLimit: json["maxLimit"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "maxLimit": maxLimit,
        "price": price,
      };
}
