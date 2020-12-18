import 'package:json_annotation/json_annotation.dart';
import 'package:pyxel/utils/date_time_parser.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  @JsonKey(name: "updated_at", fromJson: toDateTime, toJson: toString)
  final DateTime updatedAt;
  final String username;
  final String name;
  @JsonKey(name: "portfolio_url")
  final String portfolioUrl;
  final String bio;
  final String location;
  @JsonKey(name: "total_likes")
  final int totalLikes;
  @JsonKey(name: "total_photos")
  final int totalPhotos;
  @JsonKey(name: "total_collections")
  final int totalCollections;
  @JsonKey(name: "profile_image")
  final Profile profileImage;
  @JsonKey(name: "followers_count")
  final int followersCount;
  @JsonKey(name: "following_count")
  final int followingCount;

  User({this.id, this.updatedAt, this.username, this.name, this.portfolioUrl, this.bio, this.location, this.totalLikes, this.totalPhotos, this.totalCollections, this.profileImage, this.followersCount, this.followingCount});
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Profile {
  final String small;
  final String medium;
  final String large;

  Profile({this.small, this.medium, this.large});
  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}