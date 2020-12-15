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
    downloads: json['downloads'] as int,
    exif: json['exif'] == null
        ? null
        : Exif.fromJson(json['exif'] as Map<String, dynamic>),
    location: json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>),
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
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
      'downloads': instance.downloads,
      'likes': instance.likes,
      'liked_by_user': instance.liked,
      'description': instance.description,
      'urls': instance.urls,
      'exif': instance.exif,
      'location': instance.location,
      'user': instance.user,
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

Exif _$ExifFromJson(Map<String, dynamic> json) {
  return Exif(
    make: json['make'] as String,
    model: json['model'] as String,
    aperture: json['aperture'] as String,
    exposureTime: json['exposure_time'] as String,
    focalLength: json['focal_length'] as String,
    iso: json['iso'] as int,
  );
}

Map<String, dynamic> _$ExifToJson(Exif instance) => <String, dynamic>{
      'make': instance.make,
      'model': instance.model,
      'exposure_time': instance.exposureTime,
      'aperture': instance.aperture,
      'focal_length': instance.focalLength,
      'iso': instance.iso,
    };

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    city: json['city'] as String,
    country: json['country'] as String,
    position: json['position'] == null
        ? null
        : Position.fromJson(json['position'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'city': instance.city,
      'country': instance.country,
      'position': instance.position,
    };

Position _$PositionFromJson(Map<String, dynamic> json) {
  return Position(
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
