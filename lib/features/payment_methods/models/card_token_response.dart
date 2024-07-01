class CardTokenResponse {
  final String id;

  CardTokenResponse({
    required this.id,
  });

  factory CardTokenResponse.fromJson(Map<String, dynamic> json) =>
      CardTokenResponse(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
