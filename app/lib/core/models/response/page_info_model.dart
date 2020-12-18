import 'package:json_annotation/json_annotation.dart';

part 'page_info_model.g.dart';

@JsonSerializable(nullable: true, anyMap: true)
class PageInfoModel {
  int totalRows;
  int totalPages;

  PageInfoModel({this.totalPages, this.totalRows});

  factory PageInfoModel.fromJson(Map json) => _$PageInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$PageInfoModelToJson(this);
}
