class AuthUser {
  final int id;
  final String email;
  final String name;
  final String lastName;
  final String phone;

  AuthUser({
    required this.id,
    required this.email,
    required this.name,
    required this.lastName,
    required this.phone,
  });

  String get fullName => '$name $lastName';

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        lastName: json["lastName"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "lastName": lastName,
        "phone": phone,
      };
}
