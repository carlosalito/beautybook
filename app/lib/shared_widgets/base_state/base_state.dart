import 'package:beautybook/core/helpers/i18n/i18n_helper.dart';
import 'package:flutter/widgets.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  String translate(
    final String key, {
    final Map<String, String> params,
    final int quantity,
  }) {
    return I18nHelper.translate(
      context,
      key,
      quantity: quantity,
      params: params,
    );
  }
}
