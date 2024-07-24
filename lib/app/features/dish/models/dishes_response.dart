import 'package:fooddash/app/features/dish/models/dish.dart';

class DishesResponse {
  final List<Dish> items;
  final Meta meta;

  DishesResponse({
    required this.items,
    required this.meta,
  });

  factory DishesResponse.fromJson(Map<String, dynamic> json) => DishesResponse(
        items: List<Dish>.from(json["items"].map((x) => Dish.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class Meta {
  final int totalItems;
  final int itemCount;
  final int itemsPerPage;
  final int totalPages;
  final int currentPage;

  Meta({
    required this.totalItems,
    required this.itemCount,
    required this.itemsPerPage,
    required this.totalPages,
    required this.currentPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        totalItems: json["totalItems"],
        itemCount: json["itemCount"],
        itemsPerPage: json["itemsPerPage"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toJson() => {
        "totalItems": totalItems,
        "itemCount": itemCount,
        "itemsPerPage": itemsPerPage,
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}
