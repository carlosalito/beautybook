import 'package:beautybook/app_controller.dart';
import 'package:beautybook/core/constants/globals.dart';
import 'package:beautybook/core/helpers/i18n/i18n_helper.dart';
import 'package:beautybook/core/injectable/injectable.dart';
import 'package:flutter/material.dart';

class TranslateButton extends StatelessWidget {
  final controller = getIt<AppController>();

  final Language language;
  final double size;
  final Color iconColor;
  final Function callBack;

  TranslateButton({this.language, this.size, this.callBack, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.changeLanguage(context, language);
        callBack();
      },
      child: Icon(
        I18nHelper.getFlagLanguage(language),
        size: size,
        color: iconColor,
      ),
    );
  }
}
