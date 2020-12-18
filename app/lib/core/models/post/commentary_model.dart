import 'package:json_annotation/json_annotation.dart';

part 'commentary_model.g.dart';

@JsonSerializable(nullable: true, anyMap: true)
class CommentaryModel {
  String uid;
  String userUid;
  DateTime updatedAt;
  String commentary;

  CommentaryModel({this.uid, this.userUid, this.commentary, this.updatedAt});

  factory CommentaryModel.fromJson(Map json) => _$CommentaryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CommentaryModelToJson(this);
}
