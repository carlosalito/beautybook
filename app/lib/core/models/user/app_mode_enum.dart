import 'package:hive/hive.dart';

part 'app_mode_enum.g.dart';

@HiveType(typeId: 1)
enum AppMode {
  @HiveField(0)
  light,
  @HiveField(1)
  dark
}
