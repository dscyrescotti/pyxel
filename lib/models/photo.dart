import 'package:json_annotation/json_annotation.dart';
import '../utils/date_time_parser.dart';
import 'user.dart';

part 'photo.g.dart';

@JsonSerializable()
class Photo {
  final String id;
  @JsonKey(name: "created_at", fromJson: toDateTime, toJson: toString)
  final DateTime createdAt;
  @JsonKey(name: "updated_at", fromJson: toDateTime, toJson: toString)
  final DateTime updatedAt;
  final int width;
  final int height;
  final String color;
  @JsonKey(name: "blur_hash")
  final String blurHash;
  final int downloads;
  final int likes;
  @JsonKey(name: "liked_by_user")
  final bool liked;
  final String description;
  final Urls urls;
  final Exif exif;
  final Location location;
  final User user;

  Photo({this.id, this.createdAt, this.updatedAt, this.width, this.height, this.color, this.blurHash, this.likes, this.liked, this.description, this.urls, this.downloads, this.exif, this.location, this.user});

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoToJson(this);
  static List<Photo> fromJsonArray(Iterable<dynamic> list) => list.map((p) => Photo.fromJson(p)).toList();
}


@JsonSerializable()
class Urls {
  final String raw;
  final String full;
  final String small;
  final String thumb;
  final String regular;

  Urls({this.raw, this.full, this.small, this.regular, this.thumb});
  factory Urls.fromJson(Map<String, dynamic> json) => _$UrlsFromJson(json);
  Map<String, dynamic> toJson() => _$UrlsToJson(this);
}

@JsonSerializable()
class Exif {
  final String make;
  final String model;
  @JsonKey(name: "exposure_time")
  final String exposureTime;
  final String aperture;
  @JsonKey(name: "focal_length")
  final String focalLength;
  final int iso;

  Exif({this.make, this.model, this.aperture, this.exposureTime, this.focalLength, this.iso});
  factory Exif.fromJson(Map<String, dynamic> json) => _$ExifFromJson(json);
  Map<String, dynamic> toJson() => _$ExifToJson(this);
}

@JsonSerializable()
class Location {
  final String city;
  final String country;
  final Position position;

  Location({this.city, this.country, this.position});
  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class Position {
  final double latitude;
  final double longitude;

  Position({this.latitude, this.longitude});
  factory Position.fromJson(Map<String, dynamic> json) => _$PositionFromJson(json);
  Map<String, dynamic> toJson() => _$PositionToJson(this);
}