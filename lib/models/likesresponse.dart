//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

class LikesResponse {
  LikesResponse({
    required this.id,
    required this.action,
    required this.idUser,
    required this.idMeme,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int action;
  IdUser idUser;
  IdMeme idMeme;
  DateTime publishedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory LikesResponse.fromJson(String str) =>
      LikesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LikesResponse.fromMap(Map<String, dynamic> json) => LikesResponse(
        id: json["id"],
        action: json["action"],
        idUser: IdUser.fromMap(json["id_user"]),
        idMeme: IdMeme.fromMap(json["id_meme"]),
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "action": action,
        "id_user": idUser.toMap(),
        "id_meme": idMeme.toMap(),
        "published_at": publishedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class IdMeme {
  IdMeme({
    required this.id,
    required this.title,
    required this.active,
    required this.attribs,
    required this.idUser,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });

  int id;
  String title;
  dynamic active;
  dynamic attribs;
  int idUser;
  DateTime publishedAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<Image> image;

  factory IdMeme.fromJson(String str) => IdMeme.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IdMeme.fromMap(Map<String, dynamic> json) => IdMeme(
        id: json["id"],
        title: json["title"],
        active: json["active"],
        attribs: json["attribs"],
        idUser: json["id_user"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        image: List<Image>.from(json["image"].map((x) => Image.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "active": active,
        "attribs": attribs,
        "id_user": idUser,
        "published_at": publishedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "image": List<dynamic>.from(image.map((x) => x.toMap())),
      };
}

class Image {
  Image({
    required this.id,
    required this.name,
    required this.alternativeText,
    required this.caption,
    required this.width,
    required this.height,
    required this.formats,
    required this.hash,
    this.ext,
    this.mime,
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
  Ext? ext;
  Mime? mime;
  double size;
  String url;
  dynamic previewUrl;
  String provider;
  dynamic providerMetadata;
  DateTime createdAt;
  DateTime updatedAt;

  factory Image.fromJson(String str) => Image.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Image.fromMap(Map<String, dynamic> json) => Image(
        id: json["id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"],
        height: json["height"],
        formats: Formats.fromMap(json["formats"]),
        hash: json["hash"],
        ext: extValues.map[json["ext"]],
        mime: mimeValues.map[json["mime"]],
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
        "ext": extValues.reverse[ext],
        "mime": mimeValues.reverse[mime],
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": provider,
        "provider_metadata": providerMetadata,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

enum Ext { JPG }

final extValues = EnumValues({".jpg": Ext.JPG});

class Formats {
  Formats({
    required this.thumbnail,
    required this.small,
    required this.large,
    required this.medium,
  });

  Large thumbnail;
  Large? small;
  Large? large;
  Large? medium;

  factory Formats.fromJson(String str) => Formats.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Formats.fromMap(Map<String, dynamic> json) => Formats(
        thumbnail: Large.fromMap(json["thumbnail"]),
        small: Large.fromMap(json["small"]),
        large: json["large"] == null ? null : Large.fromMap(json["large"]),
        medium: json["medium"] == null ? null : Large.fromMap(json["medium"]),
      );

  Map<String, dynamic> toMap() => {
        "thumbnail": thumbnail.toMap(),
        "small": small!.toMap(),
        "large": large!.toMap(),
        "medium": medium!.toMap(),
      };
}

class Large {
  Large({
    required this.name,
    required this.hash,
    this.ext,
    this.mime,
    required this.width,
    required this.height,
    required this.size,
    required this.path,
    required this.url,
  });

  String name;
  String hash;
  Ext? ext;
  Mime? mime;
  int width;
  int height;
  double size;
  dynamic path;
  String url;

  factory Large.fromJson(String str) => Large.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Large.fromMap(Map<String, dynamic> json) => Large(
        name: json["name"],
        hash: json["hash"],
        ext: extValues.map[json["ext"]],
        mime: mimeValues.map[json["mime"]],
        width: json["width"],
        height: json["height"],
        size: json["size"].toDouble(),
        path: json["path"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "hash": hash,
        "ext": extValues.reverse[ext],
        "mime": mimeValues.reverse[mime],
        "width": width,
        "height": height,
        "size": size,
        "path": path,
        "url": url,
      };
}

enum Mime { APPLICATION_OCTET_STREAM }

final mimeValues =
    EnumValues({"application/octet-stream": Mime.APPLICATION_OCTET_STREAM});

class IdUser {
  IdUser({
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
  String provider;
  bool confirmed;
  dynamic blocked;
  int role;
  dynamic facebook;
  dynamic instagram;
  DateTime createdAt;
  DateTime updatedAt;

  factory IdUser.fromJson(String str) => IdUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IdUser.fromMap(Map<String, dynamic> json) => IdUser(
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

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap;
    return reverseMap;
  }
}
