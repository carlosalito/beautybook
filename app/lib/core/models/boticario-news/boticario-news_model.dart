import 'package:json_annotation/json_annotation.dart';

part 'boticario-news_model.g.dart';

@JsonSerializable(nullable: true, anyMap: true, fieldRename: FieldRename.snake)
class BoticarioUserModel {
  String name;
  String profilePicture;

  BoticarioUserModel({
    this.name,
    this.profilePicture,
  });

  factory BoticarioUserModel.fromJson(Map json) =>
      _$BoticarioUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$BoticarioUserModelToJson(this);
}

@JsonSerializable(nullable: true, anyMap: true, fieldRename: FieldRename.snake)
class BoticarioMessageModel {
  String content;
  DateTime createdAt;

  BoticarioMessageModel({
    this.content,
    this.createdAt,
  });

  factory BoticarioMessageModel.fromJson(Map json) =>
      _$BoticarioMessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$BoticarioMessageModelToJson(this);
}

@JsonSerializable(nullable: true, anyMap: true)
class BoticarioNewsModel {
  final BoticarioUserModel user;
  final BoticarioMessageModel message;

  BoticarioNewsModel({
    this.user,
    this.message,
  });

  factory BoticarioNewsModel.fromJson(Map json) =>
      _$BoticarioNewsModelFromJson(json);
  Map<String, dynamic> toJson() => _$BoticarioNewsModelToJson(this);
}
