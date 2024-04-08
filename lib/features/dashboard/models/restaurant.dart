class Restaurant {
  final String name;
  final String image;
  final double distance;
  final int time;
  final double record;
  final int recordPeople;
  final List<String> tags;

  Restaurant({
    required this.name,
    required this.image,
    required this.distance,
    required this.time,
    required this.record,
    required this.recordPeople,
    required this.tags,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        name: json["name"],
        image: json["image"],
        distance: json["distance"]?.toDouble(),
        time: json["time"],
        record: json["record"]?.toDouble(),
        recordPeople: json["recordPeople"],
        tags: List<String>.from(json["tags"].map((x) => x)),
      );
}
