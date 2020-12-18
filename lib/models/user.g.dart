// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    updatedAt: toDateTime(json['updated_at'] as String),
    username: json['username'] as String,
    name: json['name'] as String,
    portfolioUrl: json['portfolio_url'] as String,
    bio: json['bio'] as String,
    location: json['location'] as String,
    totalLikes: json['total_likes'] as int,
    totalPhotos: json['total_photos'] as int,
    totalCollections: json['total_collections'] as int,
    profileImage: json['profile_image'] == null
        ? null
        : Profile.fromJson(json['profile_image'] as Map<String, dynamic>),
    followersCount: json['followers_count'] as int,
    followingCount: json['following_count'] as int,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'updated_at': toString(instance.updatedAt),
      'username': instance.username,
      'name': instance.name,
      'portfolio_url': instance.portfolioUrl,
      'bio': instance.bio,
      'location': instance.location,
      'total_likes': instance.totalLikes,
      'total_photos': instance.totalPhotos,
      'total_collections': instance.totalCollections,
      'profile_image': instance.profileImage,
      'followers_count': instance.followersCount,
      'following_count': instance.followingCount,
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    small: json['small'] as String,
    medium: json['medium'] as String,
    large: json['large'] as String,
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'small': instance.small,
      'medium': instance.medium,
      'large': instance.large,
    };
