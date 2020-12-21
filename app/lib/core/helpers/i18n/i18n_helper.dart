import 'package:beautybook/core/constants/globals.dart';
import 'package:beautybook/core/icons/beautybook_icons.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class I18nHelper {
  static String translate(
    final BuildContext context,
    final String key, {
    final Map<String, String> params,
    final int quantity,
  }) {
    if (quantity != null) {
      return FlutterI18n.plural(context, key, quantity);
    }

    return FlutterI18n.translate(context, key, translationParams: params);
  }

  static Locale getLocale(Language language) {
    return language == Language.english
        ? Locale('en', 'US')
        : Locale('pt', 'BR');
  }

  static String getFalbackFile(Language language) {
    return language == Language.english ? 'en_US' : 'pt_BR';
  }

  static IconData getFlagLanguage(Language language) {
    return language == Language.english
        ? BeautybookIcons.en_US
        : BeautybookIcons.pt_Br;
  }
}
