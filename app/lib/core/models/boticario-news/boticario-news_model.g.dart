// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boticario-news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoticarioUserModel _$BoticarioUserModelFromJson(Map json) {
  return BoticarioUserModel(
    name: json['name'] as String,
    profilePicture: json['profile_picture'] as String,
  );
}

Map<String, dynamic> _$BoticarioUserModelToJson(BoticarioUserModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'profile_picture': instance.profilePicture,
    };

BoticarioMessageModel _$BoticarioMessageModelFromJson(Map json) {
  return BoticarioMessageModel(
    content: json['content'] as String,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
  );
}

Map<String, dynamic> _$BoticarioMessageModelToJson(
        BoticarioMessageModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'created_at': instance.createdAt?.toIso8601String(),
    };

BoticarioNewsModel _$BoticarioNewsModelFromJson(Map json) {
  return BoticarioNewsModel(
    user: json['user'] == null
        ? null
        : BoticarioUserModel.fromJson(json['user'] as Map),
    message: json['message'] == null
        ? null
        : BoticarioMessageModel.fromJson(json['message'] as Map),
  );
}

Map<String, dynamic> _$BoticarioNewsModelToJson(BoticarioNewsModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'message': instance.message,
    };
