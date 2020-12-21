import 'package:beautybook/core/helpers/i18n/i18n_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StringHelper {
  static String initialLetters(String name) {
    final _arrayName = name.split(' ');
    String _initial = _arrayName[0].substring(0, 1);
    if (_arrayName[1] != null) {
      _initial += _arrayName[1].substring(0, 1);
    }
    return _initial.toUpperCase();
  }

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

  static String validateTitle(BuildContext context, String value) {
    return value == null || value.isEmpty
        ? I18nHelper.translate(context, "validators.emptyTitle")
        : null;
  }

  static String validatePost(BuildContext context, String value) {
    return value == null || value.isEmpty
        ? I18nHelper.translate(context, "validators.emptyPost")
        : value.length > 280
            ? I18nHelper.translate(context, "validators.largePost")
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

  static friendlyDate(
    BuildContext context,
    DateTime date,
  ) {
    final Duration duration = DateTime.now().difference(date);

    if (duration.inMinutes < 2) {
      return I18nHelper.translate(context, 'common.now');
    } else if (duration.inMinutes < 60) {
      return I18nHelper.translate(context, 'common.minutes');
    } else if (duration.inHours < 24) {
      return I18nHelper.translate(context, 'common.hours');
    } else if (duration.inHours <= 48) {
      return I18nHelper.translate(context, 'common.yesterday');
    } else {
      return DateFormat(I18nHelper.translate(context, 'common.outputFormat'))
          .format(date);
    }
  }
}
