import 'package:beautybook/app_controller.dart';
import 'package:beautybook/app_widget.dart';
import 'package:beautybook/core/constants/storage.dart';
import 'package:beautybook/core/helpers/hive/hive_helper.dart';
import 'package:beautybook/core/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  final controller = getIt<AppController>();
  controller.setTheme(HiveHelper.getValueInBox(Storage.appMode));

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor:
        controller.theme.primaryColor, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
  ));

  runApp(
    AppWidget(),
  );
}
