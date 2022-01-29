// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

class UserResponse {
  UserResponse({
    required this.jwt,
    required this.user,
  });

  String jwt;
  User user;

  factory UserResponse.fromJson(String str) =>
      UserResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserResponse.fromMap(Map<String, dynamic> json) => UserResponse(
        jwt: json["jwt"],
        user: User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "jwt": jwt,
        "user": user.toMap(),
      };
}

class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    this.provider,
    this.confirmed,
    this.blocked,
    this.role,
    this.facebook,
    this.instagram,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String username;
  String email;
  String? provider;
  bool? confirmed;
  dynamic blocked;
  Role? role;
  dynamic facebook;
  dynamic instagram;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        provider: json["provider"],
        confirmed: json["confirmed"],
        blocked: json["blocked"],
        role: Role.fromMap(json["role"]),
        facebook: json["facebook"],
        instagram: json["instagram"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "email": email,
        "provider": provider,
        "confirmed": confirmed,
        "blocked": blocked,
        "role": role!.toMap(),
        "facebook": facebook,
        "instagram": instagram,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Role {
  Role({
    required this.id,
    required this.name,
    this.description,
    this.type,
  });

  int id;
  String name;
  String? description;
  String? type;

  factory Role.fromJson(String str) => Role.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Role.fromMap(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "type": type,
      };
}
