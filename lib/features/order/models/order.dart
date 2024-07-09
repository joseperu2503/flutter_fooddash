class Order {
  final int id;
  final double subtotal;
  final double deliveryFee;
  final double serviceFee;
  final double total;
  final List<DishOrder> dishOrders;
  final Restaurant restaurant;
  final Address address;
  final List<OrderStatus> orderStatuses;

  Order({
    required this.id,
    required this.subtotal,
    required this.deliveryFee,
    required this.serviceFee,
    required this.total,
    required this.dishOrders,
    required this.restaurant,
    required this.address,
    required this.orderStatuses,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        subtotal: json["subtotal"]?.toDouble(),
        deliveryFee: json["deliveryFee"]?.toDouble(),
        serviceFee: json["serviceFee"]?.toDouble(),
        total: json["total"]?.toDouble(),
        dishOrders: List<DishOrder>.from(
            json["dishOrders"].map((x) => DishOrder.fromJson(x))),
        restaurant: Restaurant.fromJson(json["restaurant"]),
        address: Address.fromJson(json["address"]),
        orderStatuses: List<OrderStatus>.from(
            json["orderStatuses"].map((x) => OrderStatus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subtotal": subtotal,
        "deliveryFee": deliveryFee,
        "serviceFee": serviceFee,
        "total": total,
        "dishOrders": List<dynamic>.from(dishOrders.map((x) => x.toJson())),
        "restaurant": restaurant.toJson(),
        "address": address.toJson(),
        "orderStatuses":
            List<dynamic>.from(orderStatuses.map((x) => x.toJson())),
      };
}

class Address {
  final int id;
  final String address;
  final double latitude;
  final double longitude;

  Address({
    required this.id,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        address: json["address"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
      };
}

class DishOrder {
  final int id;
  final int units;
  final Dish dish;
  final List<ToppingDishOrder> toppingDishOrders;

  DishOrder({
    required this.id,
    required this.units,
    required this.dish,
    required this.toppingDishOrders,
  });

  factory DishOrder.fromJson(Map<String, dynamic> json) => DishOrder(
        id: json["id"],
        units: json["units"],
        dish: Dish.fromJson(json["dish"]),
        toppingDishOrders: List<ToppingDishOrder>.from(
            json["toppingDishOrders"].map((x) => ToppingDishOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "units": units,
        "dish": dish.toJson(),
        "toppingDishOrders":
            List<dynamic>.from(toppingDishOrders.map((x) => x.toJson())),
      };
}

class Dish {
  final int id;
  final String name;
  final String image;
  final int price;

  Dish({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  factory Dish.fromJson(Map<String, dynamic> json) => Dish(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
      };
}

class ToppingDishOrder {
  final int id;
  final int units;
  final Topping topping;

  ToppingDishOrder({
    required this.id,
    required this.units,
    required this.topping,
  });

  factory ToppingDishOrder.fromJson(Map<String, dynamic> json) =>
      ToppingDishOrder(
        id: json["id"],
        units: json["units"],
        topping: Topping.fromJson(json["topping"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "units": units,
        "topping": topping.toJson(),
      };
}

class Topping {
  final int id;
  final String description;
  final int price;

  Topping({
    required this.id,
    required this.description,
    required this.price,
  });

  factory Topping.fromJson(Map<String, dynamic> json) => Topping(
        id: json["id"],
        description: json["description"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "price": price,
      };
}

class OrderStatus {
  final int id;
  final OrderStatusType orderStatusType;

  OrderStatus({
    required this.id,
    required this.orderStatusType,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
        id: json["id"],
        orderStatusType: OrderStatusType.fromJson(json["orderStatusType"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderStatusType": orderStatusType.toJson(),
      };
}

class OrderStatusType {
  final int id;
  final String name;

  OrderStatusType({
    required this.id,
    required this.name,
  });

  factory OrderStatusType.fromJson(Map<String, dynamic> json) =>
      OrderStatusType(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Restaurant {
  final int id;
  final String name;
  final String address;
  final String logo;
  final String backdrop;
  final double latitude;
  final double longitude;

  Restaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.logo,
    required this.backdrop,
    required this.latitude,
    required this.longitude,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        logo: json["logo"],
        backdrop: json["backdrop"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "logo": logo,
        "backdrop": backdrop,
        "latitude": latitude,
        "longitude": longitude,
      };
}
