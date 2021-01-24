import 'package:json_annotation/json_annotation.dart';
import 'package:pyxel/models/photo.dart';

part 'result.g.dart';

@JsonSerializable()
class PhotoResult {
  final int total;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  final List<Photo> results;

  PhotoResult({this.total, this.results, this.totalPages});
  factory PhotoResult.fromJson(Map<String, dynamic> json) => _$PhotoResultFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoResultToJson(this);
  static List<PhotoResult> fromJsonArray(Iterable<dynamic> list) => list.map((p) => PhotoResult.fromJson(p)).toList();
}