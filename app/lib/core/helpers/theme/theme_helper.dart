import 'package:beautybook/core/extensions/theme.dart';
import 'package:beautybook/core/models/user/app_mode_enum.dart';
import 'package:flutter/material.dart';

class ThemeHelper {
  static OutlineInputBorder enableBorder(BuildContext context, AppMode mode) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.borderColor(mode),
      ),
    );
  }

  static OutlineInputBorder focusedBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(width: 1.4, color: Theme.of(context).primaryColor),
    );
  }

  static OutlineInputBorder errorBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(width: 1.4, color: Theme.of(context).errorColor),
    );
  }

  static BoxShadow boxCard(BuildContext context) {
    return BoxShadow(
      color: Theme.of(context).primaryColorDark.withOpacity(.5),
      blurRadius: 15.0,
      spreadRadius: -5.0,
      offset: Offset(0.0, 5.0),
    );
  }
}
