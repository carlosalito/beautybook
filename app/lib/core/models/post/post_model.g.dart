// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map json) {
  return PostModel(
    uid: json['uid'] as String,
    userUid: json['userUid'] as String,
    userPicture: json['userPicture'] as String,
    userName: json['userName'] as String,
    title: json['title'] as String,
    body: json['body'] as String,
    pictures: (json['pictures'] as List)?.map((e) => e as String)?.toList(),
    commentarys: (json['commentarys'] as List)
        ?.map((e) => e == null ? null : CommentaryModel.fromJson(e as Map))
        ?.toList(),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
  );
}

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'userUid': instance.userUid,
      'userName': instance.userName,
      'userPicture': instance.userPicture,
      'title': instance.title,
      'body': instance.body,
      'pictures': instance.pictures,
      'commentarys': instance.commentarys,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
