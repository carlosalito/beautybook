import 'package:beautybook/core/constants/storage.dart';
import 'package:hive/hive.dart';

class HiveHelper {
  static dynamic getValueInBox(String key) {
    return Hive.box(Storage.mainBox).get(key);
  }

  static void deleteValueInBox(String key) {
    Hive.box(Storage.mainBox).delete(key);
  }

  static void saveValueInBox(String key, dynamic value) async {
    Hive.box(Storage.mainBox).put(key, value);
  }
}
