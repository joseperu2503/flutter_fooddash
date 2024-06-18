class RestaurantDetail {
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
  final List<DishCategory> dishCategories;
  final int distance;
  final int time;
  final double record;
  final int recordPeople;
  final List<String> tags;
  final double delivery;

  RestaurantDetail({
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
    required this.dishCategories,
    required this.distance,
    required this.time,
    required this.record,
    required this.recordPeople,
    required this.tags,
    required this.delivery,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
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
        dishCategories: List<DishCategory>.from(
            json["dishCategories"].map((x) => DishCategory.fromJson(x))),
        distance: json["distance"],
        time: json["time"],
        record: json["record"]?.toDouble(),
        recordPeople: json["recordPeople"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        delivery: json["delivery"]?.toDouble(),
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
        "dishCategories":
            List<dynamic>.from(dishCategories.map((x) => x.toJson())),
        "distance": distance,
        "time": time,
        "record": record,
        "recordPeople": recordPeople,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "delivery": delivery,
      };
}

class DishCategory {
  final int id;
  final String name;
  final bool isActive;
  final List<Dish> dishes;

  DishCategory({
    required this.id,
    required this.name,
    required this.isActive,
    required this.dishes,
  });

  factory DishCategory.fromJson(Map<String, dynamic> json) => DishCategory(
        id: json["id"],
        name: json["name"],
        isActive: json["isActive"],
        dishes: List<Dish>.from(json["dishes"]!.map((x) => Dish.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "isActive": isActive,
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
  final bool isActive;

  Dish({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.stock,
    required this.isActive,
  });

  factory Dish.fromJson(Map<String, dynamic> json) => Dish(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        stock: json["stock"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "price": price,
        "stock": stock,
        "isActive": isActive,
      };
}
