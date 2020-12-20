import 'package:equatable/equatable.dart';

abstract class BaseModel<Id> extends Equatable {
  Id get id;

  BaseModel();

  Map<String, dynamic> toJson();
}
