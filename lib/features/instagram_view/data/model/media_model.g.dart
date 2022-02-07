// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MediaModel _$$_MediaModelFromJson(Map<String, dynamic> json) =>
    _$_MediaModel(
      id: json['id'] as String,
      media_type: json['media_type'] as String,
      media_url: json['media_url'] as String,
      username: json['username'] as String,
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$$_MediaModelToJson(_$_MediaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'media_type': instance.media_type,
      'media_url': instance.media_url,
      'username': instance.username,
      'timestamp': instance.timestamp,
    };
