import 'package:beautybook/core/constants/storage.dart';
import 'package:beautybook/core/injectable/injectable.config.dart';
import 'package:beautybook/core/models/user/app_mode_enum.dart';
import 'package:beautybook/core/models/user/user_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future<void> configureDependencies() async {
  await Firebase.initializeApp();

  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(AppModeAdapter());
  await Hive.openBox(Storage.mainBox);

  $initGetIt(getIt);
}
