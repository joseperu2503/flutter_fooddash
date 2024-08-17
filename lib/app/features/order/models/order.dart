class OrdersResponse {
  final List<Order> items;
  final Meta meta;

  OrdersResponse({
    required this.items,
    required this.meta,
  });

  factory OrdersResponse.fromJson(Map<String, dynamic> json) => OrdersResponse(
        items: List<Order>.from(json["items"].map((x) => Order.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );
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

class Order {
  final int id;
  final double subtotal;
  final double deliveryFee;
  final double serviceFee;
  final double total;
  final List<DishOrder> dishOrders;
  final Restaurant restaurant;
  final Address address;
  final OrderStatus orderStatus;
  final EstimatedDelivery estimatedDelivery;
  final DateTime? deliveredDate;

  Order({
    required this.id,
    required this.subtotal,
    required this.deliveryFee,
    required this.serviceFee,
    required this.total,
    required this.dishOrders,
    required this.restaurant,
    required this.address,
    required this.orderStatus,
    required this.estimatedDelivery,
    required this.deliveredDate,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        subtotal: json["subtotal"]?.toDouble(),
        deliveryFee: json["deliveryFee"]?.toDouble(),
        serviceFee: json["serviceFee"]?.toDouble(),
        total: json["total"]?.toDouble(),
        deliveredDate: json["deliveredDate"] == null
            ? null
            : DateTime.parse(json["deliveredDate"]),
        dishOrders: List<DishOrder>.from(
            json["dishOrders"].map((x) => DishOrder.fromJson(x))),
        restaurant: Restaurant.fromJson(json["restaurant"]),
        address: Address.fromJson(json["address"]),
        orderStatus: OrderStatus.fromJson(json["orderStatus"]),
        estimatedDelivery:
            EstimatedDelivery.fromJson(json["estimatedDelivery"]),
      );
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
  final String description;
  final double price;

  Dish({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
  });

  factory Dish.fromJson(Map<String, dynamic> json) => Dish(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
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
  final double price;

  Topping({
    required this.id,
    required this.description,
    required this.price,
  });

  factory Topping.fromJson(Map<String, dynamic> json) => Topping(
        id: json["id"],
        description: json["description"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "price": price,
      };
}

class EstimatedDelivery {
  final DateTime min;
  final DateTime max;

  EstimatedDelivery({
    required this.min,
    required this.max,
  });

  factory EstimatedDelivery.fromJson(Map<String, dynamic> json) =>
      EstimatedDelivery(
        min: DateTime.parse(json["min"]),
        max: DateTime.parse(json["max"]),
      );

  Map<String, dynamic> toJson() => {
        "min": min.toIso8601String(),
        "max": max.toIso8601String(),
      };
}

class OrderStatus {
  final int id;
  final String name;

  OrderStatus({
    required this.id,
    required this.name,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
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
