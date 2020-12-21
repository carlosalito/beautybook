import 'package:hive/hive.dart';

part 'globals.g.dart';

@HiveType(typeId: 1)
enum AppMode {
  @HiveField(0)
  light,
  @HiveField(1)
  dark
}

@HiveType(typeId: 2)
enum Language {
  @HiveField(0)
  portuguese,
  @HiveField(1)
  english
}
