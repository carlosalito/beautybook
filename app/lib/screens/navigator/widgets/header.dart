import 'package:beautybook/app_controller.dart';
import 'package:beautybook/core/injectable/injectable.dart';
import 'package:beautybook/core/models/user/app_mode_enum.dart';
import 'package:flutter/material.dart';

class NavigatorHeader extends StatelessWidget {
  final appController = getIt<AppController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Row(
        children: <Widget>[
          Hero(
            tag: 'logo',
            child: Container(
              height: 80,
              width: constraints.maxWidth * 0.55,
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(appController.appMode == AppMode.dark
                        ? 'assets/images/logo_pb.png'
                        : 'assets/images/logo.png'),
                    fit: BoxFit.contain),
              ),
            ),
          ),
        ],
      );
    });
  }
}
