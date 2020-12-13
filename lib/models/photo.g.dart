// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photo _$PhotoFromJson(Map<String, dynamic> json) {
  return Photo(
    id: json['id'] as String,
    createdAt: toDateTime(json['created_at'] as String),
    updatedAt: toDateTime(json['updated_at'] as String),
    width: json['width'] as int,
    height: json['height'] as int,
    color: json['color'] as String,
    blurHash: json['blur_hash'] as String,
    likes: json['likes'] as int,
    liked: json['liked_by_user'] as bool,
    description: json['description'] as String,
    urls: json['urls'] == null
        ? null
        : Urls.fromJson(json['urls'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': toString(instance.createdAt),
      'updated_at': toString(instance.updatedAt),
      'width': instance.width,
      'height': instance.height,
      'color': instance.color,
      'blur_hash': instance.blurHash,
      'likes': instance.likes,
      'liked_by_user': instance.liked,
      'description': instance.description,
      'urls': instance.urls,
    };

Urls _$UrlsFromJson(Map<String, dynamic> json) {
  return Urls(
    raw: json['raw'] as String,
    full: json['full'] as String,
    small: json['small'] as String,
    regular: json['regular'] as String,
    thumb: json['thumb'] as String,
  );
}

Map<String, dynamic> _$UrlsToJson(Urls instance) => <String, dynamic>{
      'raw': instance.raw,
      'full': instance.full,
      'small': instance.small,
      'thumb': instance.thumb,
      'regular': instance.regular,
    };
