class Card {
  final String cardNumber;
  final String name;
  final String expired;
  final String ccv;
  final CardBrand cardBrand;
  final CardType cardType;

  Card({
    required this.cardNumber,
    required this.name,
    required this.expired,
    required this.ccv,
    required this.cardBrand,
    required this.cardType,
  });
}

enum CardType { credit, debit }

enum CardBrand {
  otherBrand,
  mastercard,
  visa,
  rupay,
  americanExpress,
  unionpay,
  discover,
  elo,
  hipercard,
}
