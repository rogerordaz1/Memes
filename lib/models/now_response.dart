// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

class Memes {
  Memes({
    required this.id,
    required this.title,
    required this.active,
    this.attribs,
    this.idUser,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });

  int id;
  String? title;
  bool? active;
  dynamic attribs;
  dynamic idUser;
  DateTime publishedAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<Imagen> image;

  factory Memes.fromJson(String str) => Memes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Memes.fromMap(Map<String, dynamic> json) => Memes(
        id: json["id"],
        title: json["title"],
        active: json["active"],
        attribs: json["attribs"],
        idUser: json["id_user"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        image: List<Imagen>.from(json["image"].map((x) => Imagen.fromMap(x))),
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

class Imagen {
  Imagen({
    required this.id,
    required this.name,
    this.alternativeText,
    this.caption,
    required this.width,
    required this.height,
    required this.formats,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    this.previewUrl,
    required this.provider,
    this.providerMetadata,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String? alternativeText;
  String? caption;
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
    required this.medium,
    required this.small,
  });

  Thumbnail? thumbnail;
  Thumbnail? medium;
  Thumbnail? small;

  factory Formats.fromJson(String str) => Formats.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Formats.fromMap(Map<String, dynamic> json) => Formats(
        thumbnail: Thumbnail.fromMap(json["thumbnail"]),
        medium:
            json["medium"] == null ? null : Thumbnail.fromMap(json["medium"]),
        small: json["small"] == null ? null : Thumbnail.fromMap(json["small"]),
      );

  Map<String, dynamic> toMap() => {
        "thumbnail": thumbnail!.toMap(),
        "medium": medium == null ? null : medium!.toMap(),
        "small": small == null ? null : small!.toMap(),
      };
}

class Thumbnail {
  Thumbnail({
    required this.name,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.width,
    required this.height,
    required this.size,
    this.path,
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

  factory Thumbnail.fromJson(String str) => Thumbnail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Thumbnail.fromMap(Map<String, dynamic> json) => Thumbnail(
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
