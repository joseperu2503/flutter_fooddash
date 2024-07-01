class BankCard {
  final String id;
  final int expirationMonth;
  final int expirationYear;
  final String firstSixDigits;
  final String lastFourDigits;
  final String issuer;
  final CardHolder cardHolder;
  final SecurityCode securityCode;
  final PaymentMethod paymentMethod;

  BankCard({
    required this.id,
    required this.expirationMonth,
    required this.expirationYear,
    required this.firstSixDigits,
    required this.lastFourDigits,
    required this.issuer,
    required this.cardHolder,
    required this.securityCode,
    required this.paymentMethod,
  });

  factory BankCard.fromJson(Map<String, dynamic> json) => BankCard(
        id: json["id"],
        expirationMonth: json["expirationMonth"],
        expirationYear: json["expirationYear"],
        firstSixDigits: json["firstSixDigits"],
        lastFourDigits: json["lastFourDigits"],
        issuer: json["issuer"],
        cardHolder: CardHolder.fromJson(json["cardHolder"]),
        securityCode: SecurityCode.fromJson(json["securityCode"]),
        paymentMethod: PaymentMethod.fromJson(json["paymentMethod"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "expirationMonth": expirationMonth,
        "expirationYear": expirationYear,
        "firstSixDigits": firstSixDigits,
        "lastFourDigits": lastFourDigits,
        "issuer": issuer,
        "cardHolder": cardHolder.toJson(),
        "securityCode": securityCode.toJson(),
        "paymentMethod": paymentMethod.toJson(),
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

class PaymentMethod {
  final String id;
  final String name;
  final String paymentTypeId;
  final String thumbnail;
  final String secureThumbnail;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.paymentTypeId,
    required this.thumbnail,
    required this.secureThumbnail,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"],
        name: json["name"],
        paymentTypeId: json["paymentTypeId"],
        thumbnail: json["thumbnail"],
        secureThumbnail: json["secureThumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "paymentTypeId": paymentTypeId,
        "thumbnail": thumbnail,
        "secureThumbnail": secureThumbnail,
      };
}

class SecurityCode {
  final int length;
  final String cardLocation;

  SecurityCode({
    required this.length,
    required this.cardLocation,
  });

  factory SecurityCode.fromJson(Map<String, dynamic> json) => SecurityCode(
        length: json["length"],
        cardLocation: json["cardLocation"],
      );

  Map<String, dynamic> toJson() => {
        "length": length,
        "cardLocation": cardLocation,
      };
}
