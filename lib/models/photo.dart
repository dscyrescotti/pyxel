import 'package:json_annotation/json_annotation.dart';
import '../utils/date_time_parser.dart';

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
  final int likes;
  @JsonKey(name: "liked_by_user")
  final bool liked;
  final String description;
  final Urls urls;

  Photo({this.id, this.createdAt, this.updatedAt, this.width, this.height, this.color, this.blurHash, this.likes, this.liked, this.description, this.urls});

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