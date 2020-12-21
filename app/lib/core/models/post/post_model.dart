import 'package:beautybook/core/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable(nullable: true, anyMap: true)
class PostModel extends BaseModel<String> {
  final String uid;
  final String userUid;
  final String userName;
  final String userPicture;
  final String title;
  final String body;
  final List<String> pictures;
  final DateTime createdAt;
  final DateTime updatedAt;

  PostModel({
    this.uid,
    this.userUid,
    this.userPicture,
    this.userName,
    this.title,
    this.body,
    this.pictures,
    this.createdAt,
    this.updatedAt,
  });

  factory PostModel.fromJson(Map json) => _$PostModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  @override
  String get id => this.uid;

  @override
  List<Object> get props => [uid];
}
