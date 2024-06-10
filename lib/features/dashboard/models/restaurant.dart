class Restaurant {
  int id;
  String name;
  String address;
  String logo;
  String backdrop;
  double latitude;
  double longitude;
  bool isActive;
  String openTime;
  String closeTime;

  RestaurantCategory restaurantCategory;
  int distance;
  int time;
  double record;
  int recordPeople;
  List<String> tags;
  double delivery;

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
    required this.restaurantCategory,
    required this.distance,
    required this.time,
    required this.record,
    required this.recordPeople,
    required this.tags,
    required this.delivery,
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
        restaurantCategory:
            RestaurantCategory.fromJson(json["restaurantCategory"]),
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
        "restaurantCategory": restaurantCategory.toJson(),
        "distance": distance,
        "time": time,
        "record": record,
        "recordPeople": recordPeople,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "delivery": delivery,
      };
}

class RestaurantCategory {
  int id;
  String name;
  String image;
  bool isActive;

  RestaurantCategory({
    required this.id,
    required this.name,
    required this.image,
    required this.isActive,
  });

  factory RestaurantCategory.fromJson(Map<String, dynamic> json) =>
      RestaurantCategory(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "isActive": isActive,
      };
}
