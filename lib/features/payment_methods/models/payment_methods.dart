class PaymentMethod {
  final String id;
  final String description;
  final int? expirationMonth;
  final int? expirationYear;
  final String? firstSixDigits;
  final String? lastFourDigits;
  final String? issuer;
  final CardHolder cardHolder;
  final String image;

  PaymentMethod({
    required this.id,
    required this.description,
    required this.expirationMonth,
    required this.expirationYear,
    required this.firstSixDigits,
    required this.lastFourDigits,
    required this.issuer,
    required this.cardHolder,
    required this.image,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"],
        description: json["description"],
        expirationMonth: json["expirationMonth"],
        expirationYear: json["expirationYear"],
        firstSixDigits: json["firstSixDigits"],
        lastFourDigits: json["lastFourDigits"],
        issuer: json["issuer"],
        cardHolder: CardHolder.fromJson(json["cardHolder"]),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "expirationMonth": expirationMonth,
        "expirationYear": expirationYear,
        "firstSixDigits": firstSixDigits,
        "lastFourDigits": lastFourDigits,
        "issuer": issuer,
        "cardHolder": cardHolder.toJson(),
        "image": image,
      };
}

class CardHolder {
  final String? name;

  CardHolder({
    required this.name,
  });

  factory CardHolder.fromJson(Map<String, dynamic> json) => CardHolder(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
