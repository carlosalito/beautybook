import 'package:beautybook/core/helpers/i18n/i18n_helper.dart';
import 'package:flutter/widgets.dart';

mixin I18n {
  String i18nContext() {
    throw UnimplementedError(
      'Should overrides i18nContext method in order to use it',
    );
  }

  String translate(final BuildContext context, final String key,
      {final Map<String, String> params, final int quantity}) {
    return I18nHelper.translate(
      context,
      key.startsWith('.') ? '${i18nContext()}$key' : key,
      quantity: quantity,
      params: params,
    );
  }
}
