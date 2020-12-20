import 'dart:io';
import 'dart:math' as math;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class UtilsServices {
  UtilsServices();

  static String uId() {
    return (_s4() +
        _s4() +
        '-' +
        _s4() +
        '-' +
        _s4() +
        '-' +
        _s4() +
        '-' +
        _s4() +
        _s4() +
        _s4());
  }

  static String _s4() {
    return ((1 + math.Random().nextDouble()) * 0x10000)
        .floor()
        .toRadixString(16)
        .substring(1);
  }

  static UploadTask uploadFileAndGetUrl(String fileLocationUrl, File file) {
    try {
      UploadTask task =
          FirebaseStorage.instance.ref().child(fileLocationUrl).putFile(file);

      return task;
    } catch (e) {
      return null;
    }
  }

  static getStorageReference(String url) {
    final String rawRef = url.split('.com/o/')[1];
    return rawRef.split('?')[0].replaceAll('%2F', '/');
  }

  static Future<String> saveTempImage(File file, ImageSource source) async {
    if (source == ImageSource.gallery) {
      final dir = await getApplicationDocumentsDirectory();
      final String newPath = dir.path + uId() + '.jpg';
      file.copy(newPath);
      return Future.value(newPath);
    } else {
      return Future.value(file.path);
    }
  }
}
