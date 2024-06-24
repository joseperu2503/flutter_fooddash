class Address {
  final int id;
  final String city;
  final String country;
  final String address;
  final String? detail;
  final String references;
  final double latitude;
  final double longitude;
  final AddressTag? addressTag;
  final AddressDeliveryDetail? addressDeliveryDetail;

  Address({
    required this.id,
    required this.city,
    required this.country,
    required this.address,
    required this.detail,
    required this.references,
    required this.latitude,
    required this.longitude,
    required this.addressTag,
    required this.addressDeliveryDetail,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        city: json["city"],
        country: json["country"],
        address: json["address"],
        detail: json["detail"],
        references: json["references"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        addressTag: json["addressTag"] == null
            ? null
            : AddressTag.fromJson(json["addressTag"]),
        addressDeliveryDetail: json["addressDeliveryDetail"] == null
            ? null
            : AddressDeliveryDetail.fromJson(json["addressDeliveryDetail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
        "country": country,
        "address": address,
        "detail": detail,
        "references": references,
        "latitude": latitude,
        "longitude": longitude,
        "addressTag": addressTag?.toJson(),
        "addressDeliveryDetail": addressDeliveryDetail?.toJson(),
      };
}

class AddressDeliveryDetail {
  final int id;
  final String name;

  AddressDeliveryDetail({
    required this.id,
    required this.name,
  });

  factory AddressDeliveryDetail.fromJson(Map<String, dynamic> json) =>
      AddressDeliveryDetail(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class AddressTag {
  final int id;
  final String name;

  AddressTag({
    required this.id,
    required this.name,
  });

  factory AddressTag.fromJson(Map<String, dynamic> json) => AddressTag(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
