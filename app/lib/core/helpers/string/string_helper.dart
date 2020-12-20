import 'package:beautybook/core/helpers/i18n/i18n_helper.dart';
import 'package:flutter/material.dart';

class StringHelper {
  static String validateEmail(BuildContext context, String value) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);

    if (value.length == 0) {
      return I18nHelper.translate(context, "validators.emptyEmail");
    } else if (!emailValid) {
      return I18nHelper.translate(context, "validators.invalidEmail");
    } else {
      return null;
    }
  }

  static String validateName(BuildContext context, String value) {
    return value == null || value.isEmpty
        ? I18nHelper.translate(context, "validators.emptyName")
        : null;
  }

  static String validatePassword(BuildContext context, String value) {
    if (value.length == 0) {
      return I18nHelper.translate(context, "validators.emptyPassword");
    } else if (value.length < 6) {
      return I18nHelper.translate(context, "validators.invalidPassword");
    } else {
      return null;
    }
  }
}
