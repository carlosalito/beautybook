import 'package:auto_route/auto_route.dart';
import 'package:beautybook/app_controller.dart';
import 'package:beautybook/core/constants/storage.dart';
import 'package:beautybook/core/constants/theme.dart';
import 'package:beautybook/core/helpers/hive/hive_helper.dart';
import 'package:beautybook/core/injectable/injectable.dart';
import 'package:beautybook/core/router/router.gr.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = getIt<AppController>();

  void _checkUser() async {
    await controller.loadCurrentUser(userCreated: null);
    if (controller.user != null) {
      ExtendedNavigator.root.popAndPush(Routes.navigatorScreen);
    } else {
      ExtendedNavigator.root.popAndPush(Routes.signInScreen);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _applyLanguage();
    });
  }

  _applyLanguage() {
    final language = HiveHelper.getValueInBox(Storage.language);
    controller.changeLanguage(context, language);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(),
            ),
            Container(
              width: 300,
              height: 300,
              child: FlareActor(
                "assets/animations/splash.flr",
                animation: 'intro',
                fit: BoxFit.fitWidth,
                callback: (_) => _checkUser(),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Text('Developed by: Carlos Alito'),
            Padding(
              padding: EdgeInsets.only(bottom: Constants.padding),
              child: Text('E-mail: carlosalito@gmail.com'),
            ),
          ],
        ),
      ),
    );
  }
}
