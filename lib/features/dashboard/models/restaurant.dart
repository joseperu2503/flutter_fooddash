import 'package:delivery_app/features/restaurant/models/dish_category.dart';

class Restaurant {
  final int id;
  final String name;
  final String image;
  final String logo;

  final double distance;
  final int time;
  final double record;
  final int recordPeople;
  final List<String> tags;
  final double sheeping;
  final List<DishCategory> menu;
  final String address;

  Restaurant({
    required this.id,
    required this.name,
    required this.image,
    required this.distance,
    required this.time,
    required this.record,
    required this.recordPeople,
    required this.tags,
    required this.sheeping,
    required this.menu,
    required this.address,
    required this.logo,
  });
}
