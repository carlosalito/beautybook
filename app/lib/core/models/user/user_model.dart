import 'package:beautybook/core/models/base_model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(nullable: true, anyMap: true)
class UserModel extends BaseModel<String> {
  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String picture;
  @HiveField(4)
  final DateTime updatedAt;
  @HiveField(5)
  final DateTime createdAt;
  final String password;

  @JsonKey(ignore: true)
  final String token;

  UserModel(
      {this.uid,
      this.name,
      this.email,
      this.picture,
      this.token,
      this.createdAt,
      this.updatedAt,
      this.password});

  factory UserModel.fromJson(Map json) => _$UserModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  get id => this.uid;

  @override
  List<Object> get props => [uid];
}
