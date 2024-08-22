class RestaurantCategory {
  int id;
  String name;
  String image;

  RestaurantCategory({
    required this.id,
    required this.name,
    required this.image,
  });

  factory RestaurantCategory.fromJson(Map<String, dynamic> json) =>
      RestaurantCategory(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
