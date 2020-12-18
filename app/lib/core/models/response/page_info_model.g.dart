// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageInfoModel _$PageInfoModelFromJson(Map json) {
  return PageInfoModel(
    totalPages: json['totalPages'] as int,
    totalRows: json['totalRows'] as int,
  );
}

Map<String, dynamic> _$PageInfoModelToJson(PageInfoModel instance) =>
    <String, dynamic>{
      'totalRows': instance.totalRows,
      'totalPages': instance.totalPages,
    };
