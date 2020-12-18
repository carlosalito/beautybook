import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(nullable: true, anyMap: true)
class UserModel {
  @HiveField(0)
  String uid;
  @HiveField(1)
  String name;
  @HiveField(2)
  String email;
  @HiveField(3)
  String picture;
  @HiveField(4)
  DateTime updatedAt;
  String password;

  @JsonKey(ignore: true)
  String token;

  UserModel(
      {this.uid,
      this.name,
      this.email,
      this.picture,
      this.token,
      this.updatedAt,
      this.password});

  factory UserModel.fromJson(Map json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
