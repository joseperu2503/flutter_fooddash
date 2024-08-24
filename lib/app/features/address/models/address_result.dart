class AddressResult {
  final String placeId;
  final StructuredFormatting structuredFormatting;

  AddressResult({
    required this.placeId,
    required this.structuredFormatting,
  });

  factory AddressResult.fromJson(Map<String, dynamic> json) => AddressResult(
        placeId: json["placeId"],
        structuredFormatting:
            StructuredFormatting.fromJson(json["structuredFormatting"]),
      );

  Map<String, dynamic> toJson() => {
        "placeId": placeId,
        "structuredFormatting": structuredFormatting.toJson(),
      };
}

class StructuredFormatting {
  final String mainText;
  final String secondaryText;

  StructuredFormatting({
    required this.mainText,
    required this.secondaryText,
  });

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) =>
      StructuredFormatting(
        mainText: json["mainText"],
        secondaryText: json["secondaryText"],
      );

  Map<String, dynamic> toJson() => {
        "mainText": mainText,
        "secondaryText": secondaryText,
      };
}
