// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

class Memes {
  Memes({
    required this.id,
    this.title,
    this.active,
    this.attribs,
    required this.idUser,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
    required this.likees,
  });

  int id;
  String? title;
  dynamic active;
  dynamic attribs;
  User idUser;
  DateTime publishedAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<Imagen> image;
  List<Likee> likees;

  factory Memes.fromJson(String str) => Memes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Memes.fromMap(Map<String, dynamic> json) => Memes(
        id: json["id"],
        title: json["title"],
        active: json["active"],
        attribs: json["attribs"],
        idUser: User.fromMap(json["id_user"]),
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        image: List<Imagen>.from(json["image"].map((x) => Imagen.fromMap(x))),
        likees: List<Likee>.from(json["likees"].map((x) => Likee.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "active": active,
        "attribs": attribs,
        "id_user": idUser.toMap(),
        "published_at": publishedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "image": List<dynamic>.from(image.map((x) => x.toMap())),
        "likees": List<dynamic>.from(likees.map((x) => x.toMap())),
      };
}

class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.provider,
    required this.confirmed,
    required this.blocked,
    required this.role,
    required this.facebook,
    required this.instagram,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String username;
  String email;
  String? provider;
  bool confirmed;
  dynamic blocked;
  int? role;
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
        role: json["role"],
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
        "role": role,
        "facebook": facebook,
        "instagram": instagram,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Imagen {
  Imagen({
    required this.id,
    required this.name,
    required this.alternativeText,
    required this.caption,
    required this.width,
    required this.height,
    required this.formats,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    required this.previewUrl,
    required this.provider,
    required this.providerMetadata,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  dynamic alternativeText;
  dynamic caption;
  int width;
  int height;
  Formats formats;
  String hash;
  String ext;
  String mime;
  double size;
  String url;
  dynamic previewUrl;
  String provider;
  dynamic providerMetadata;
  DateTime createdAt;
  DateTime updatedAt;

  factory Imagen.fromJson(String str) => Imagen.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Imagen.fromMap(Map<String, dynamic> json) => Imagen(
        id: json["id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"],
        height: json["height"],
        formats: Formats.fromMap(json["formats"]),
        hash: json["hash"],
        ext: json["ext"],
        mime: json["mime"],
        size: json["size"].toDouble(),
        url: json["url"],
        previewUrl: json["previewUrl"],
        provider: json["provider"],
        providerMetadata: json["provider_metadata"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "alternativeText": alternativeText,
        "caption": caption,
        "width": width,
        "height": height,
        "formats": formats.toMap(),
        "hash": hash,
        "ext": ext,
        "mime": mime,
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": provider,
        "provider_metadata": providerMetadata,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Formats {
  Formats({
    required this.thumbnail,
    required this.small,
    required this.large,
    required this.medium,
  });

  Small thumbnail;
  Small? small;
  Small? large;
  Small? medium;

  factory Formats.fromJson(String str) => Formats.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Formats.fromMap(Map<String, dynamic> json) => Formats(
        thumbnail: Small.fromMap(json["thumbnail"]),
        small: Small.fromMap(json["small"]),
        large: json["large"] == null ? null : Small.fromMap(json["large"]),
        medium: json["medium"] == null ? null : Small.fromMap(json["medium"]),
      );

  Map<String, dynamic> toMap() => {
        "thumbnail": thumbnail.toMap(),
        "small": small!.toMap(),
        "large": large!.toMap(),
        "medium": medium!.toMap(),
      };
}

class Small {
  Small({
    required this.name,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.width,
    required this.height,
    required this.size,
    required this.path,
    required this.url,
  });

  String name;
  String hash;
  String ext;
  String mime;
  int width;
  int height;
  double size;
  dynamic path;
  String url;

  factory Small.fromJson(String str) => Small.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Small.fromMap(Map<String, dynamic> json) => Small(
        name: json["name"],
        hash: json["hash"],
        ext: json["ext"],
        mime: json["mime"],
        width: json["width"],
        height: json["height"],
        size: json["size"].toDouble(),
        path: json["path"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "hash": hash,
        "ext": ext,
        "mime": mime,
        "width": width,
        "height": height,
        "size": size,
        "path": path,
        "url": url,
      };
}

class Likee {
  Likee({
    required this.id,
    required this.action,
    required this.idUser,
    required this.idMeme,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int? action;
  int idUser;
  int idMeme;
  DateTime publishedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Likee.fromJson(String str) => Likee.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Likee.fromMap(Map<String, dynamic> json) => Likee(
        id: json["id"],
        action: json["action"],
        idUser: json["id_user"],
        idMeme: json["id_meme"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "action": action,
        "id_user": idUser,
        "id_meme": idMeme,
        "published_at": publishedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
