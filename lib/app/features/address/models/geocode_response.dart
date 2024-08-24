class GeocodeResponse {
  final String address;
  final String country;
  final String locality;

  GeocodeResponse({
    required this.address,
    required this.country,
    required this.locality,
  });

  factory GeocodeResponse.fromJson(Map<String, dynamic> json) =>
      GeocodeResponse(
        address: json["address"],
        country: json["country"],
        locality: json["locality"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "country": country,
        "locality": locality,
      };
}
