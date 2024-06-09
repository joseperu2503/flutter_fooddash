import 'package:delivery_app/features/dashboard/models/category.dart';

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
  String createdAt;
  String updatedAt;
  Category category;
  int distance;
  int time;
  double record;
  int recordPeople;
  List<String> tags;
  double delivery;
  String date;

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
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.distance,
    required this.time,
    required this.record,
    required this.recordPeople,
    required this.tags,
    required this.delivery,
    required this.date,
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
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        category: Category.fromJson(json["category"]),
        distance: json["distance"],
        time: json["time"],
        record: json["record"]?.toDouble(),
        recordPeople: json["recordPeople"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        delivery: json["delivery"]?.toDouble(),
        date: json["date"],
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
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "category": category.toJson(),
        "distance": distance,
        "time": time,
        "record": record,
        "recordPeople": recordPeople,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "delivery": delivery,
        "date": date,
      };
}
