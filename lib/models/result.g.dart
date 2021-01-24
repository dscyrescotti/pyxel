// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoResult _$PhotoResultFromJson(Map<String, dynamic> json) {
  return PhotoResult(
    total: json['total'] as int,
    results: (json['results'] as List)
        ?.map(
            (e) => e == null ? null : Photo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    totalPages: json['total_pages'] as int,
  );
}

Map<String, dynamic> _$PhotoResultToJson(PhotoResult instance) =>
    <String, dynamic>{
      'total': instance.total,
      'total_pages': instance.totalPages,
      'results': instance.results,
    };
