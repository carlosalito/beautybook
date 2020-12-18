import 'package:beautybook/core/models/post/commentary_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable(nullable: true, anyMap: true)
class PostModel {
  String uid;
  String userUid;
  String userName;
  String userPicture;
  String title;
  String body;
  List<String> pictures;
  List<CommentaryModel> commentarys;
  DateTime createdAt;
  DateTime updatedAt;

  PostModel(
      {this.uid,
      this.userUid,
      this.userPicture,
      this.userName,
      this.title,
      this.body,
      this.pictures,
      this.commentarys,
      this.createdAt,
      this.updatedAt});

  factory PostModel.fromJson(Map json) => _$PostModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
