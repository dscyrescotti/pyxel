import 'package:json_annotation/json_annotation.dart';
import 'package:pyxel/models/photo.dart';
import 'package:pyxel/models/user.dart';
import '../utils/date_time_parser.dart';

part 'collection.g.dart';

@JsonSerializable()
class Collection {
  final int id;
  final String title;
  final String description;
  @JsonKey(name: 'published_at', fromJson: toDateTime, toJson: toString)
  final DateTime publishedAt;
  @JsonKey(name: 'updated_at', fromJson: toDateTime, toJson: toString)
  final DateTime updatedAt;
  @JsonKey(name: 'share_key')
  final String shareKey;
  final bool private;
  @JsonKey(name: 'total_photos')
  final int totalPhotos;
  @JsonKey(name: 'cover_photo')
  final Photo coverPhoto;
  final User user;

  Collection({this.id, this.title, this.description, this.publishedAt, this.updatedAt, this.shareKey, this.private, this.totalPhotos, this.coverPhoto, this.user});
  factory Collection.fromJson(Map<String, dynamic> json) => _$CollectionFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionToJson(this);
  static List<Collection> fromJsonArray(Iterable<dynamic> list) => list.map((p) => Collection.fromJson(p)).toList();
}