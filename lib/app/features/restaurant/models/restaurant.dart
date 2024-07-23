class Restaurant {
  final int id;
  final String name;
  final String address;
  final String logo;
  final String backdrop;
  final double latitude;
  final double longitude;
  final String openTime;
  final String closeTime;
  final double distance;
  final double time;
  final double record;
  final int recordPeople;
  final double delivery;
  final bool isFavorite;

  Restaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.logo,
    required this.backdrop,
    required this.latitude,
    required this.longitude,
    required this.openTime,
    required this.closeTime,
    required this.distance,
    required this.time,
    required this.record,
    required this.recordPeople,
    required this.delivery,
    required this.isFavorite,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        logo: json["logo"],
        backdrop: json["backdrop"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        openTime: json["openTime"],
        closeTime: json["closeTime"],
        distance: json["distance"]?.toDouble(),
        time: json["time"]?.toDouble(),
        record: json["record"]?.toDouble(),
        recordPeople: json["recordPeople"],
        delivery: json["delivery"]?.toDouble(),
        isFavorite: json["isFavorite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "logo": logo,
        "backdrop": backdrop,
        "latitude": latitude,
        "longitude": longitude,
        "openTime": openTime,
        "closeTime": closeTime,
        "distance": distance,
        "time": time,
        "record": record,
        "recordPeople": recordPeople,
        "delivery": delivery,
        "isFavorite": isFavorite,
      };
}
