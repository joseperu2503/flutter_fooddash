class Topping {
  final String name;
  final double price;

  Topping({
    required this.name,
    required this.price,
  });

  factory Topping.fromJson(Map<String, dynamic> json) => Topping(
        name: json["name"],
        price: json["price"]?.toDouble(),
      );
}
