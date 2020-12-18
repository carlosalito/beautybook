// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentaryModel _$CommentaryModelFromJson(Map json) {
  return CommentaryModel(
    uid: json['uid'] as String,
    userUid: json['userUid'] as String,
    commentary: json['commentary'] as String,
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
  );
}

Map<String, dynamic> _$CommentaryModelToJson(CommentaryModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'userUid': instance.userUid,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'commentary': instance.commentary,
    };
