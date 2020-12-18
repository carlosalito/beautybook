// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_mode_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppModeAdapter extends TypeAdapter<AppMode> {
  @override
  final int typeId = 1;

  @override
  AppMode read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AppMode.light;
      case 1:
        return AppMode.dark;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, AppMode obj) {
    switch (obj) {
      case AppMode.light:
        writer.writeByte(0);
        break;
      case AppMode.dark:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
