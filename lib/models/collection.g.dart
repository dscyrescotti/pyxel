// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collection _$CollectionFromJson(Map<String, dynamic> json) {
  return Collection(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    publishedAt: toDateTime(json['published_at'] as String),
    updatedAt: toDateTime(json['updated_at'] as String),
    shareKey: json['share_key'] as String,
    private: json['private'] as bool,
    totalPhotos: json['total_photos'] as int,
    coverPhoto: json['cover_photo'] == null
        ? null
        : Photo.fromJson(json['cover_photo'] as Map<String, dynamic>),
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    tags: (json['tags'] as List)
        ?.map((e) => e == null ? null : Tag.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CollectionToJson(Collection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'published_at': toString(instance.publishedAt),
      'updated_at': toString(instance.updatedAt),
      'share_key': instance.shareKey,
      'private': instance.private,
      'total_photos': instance.totalPhotos,
      'cover_photo': instance.coverPhoto,
      'user': instance.user,
      'tags': instance.tags,
    };
