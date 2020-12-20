import 'package:beautybook/app_controller.dart';
import 'package:beautybook/core/constants/globals.dart';
import 'package:beautybook/core/helpers/i18n/i18n_helper.dart';
import 'package:beautybook/core/injectable/injectable.dart';
import 'package:flutter/material.dart';

class TranslateButton extends StatelessWidget {
  final controller = getIt<AppController>();

  final Language language;
  final double size;
  final Function callBack;

  TranslateButton({this.language, this.size, this.callBack});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          controller.changeLanguage(context, language);
          callBack();
        },
        child: Container(
            width: size,
            height: size,
            decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                        'assets/images/${I18nHelper.getFlagLanguage(language)}.png')))));
  }
}
