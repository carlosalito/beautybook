import 'package:beautybook/core/constants/globals.dart';
import 'package:flutter/material.dart';

final Color primaryBase = Color(0xFFB41EB3);

extension CustomColorScheme on ColorScheme {
  Color borderColor(AppMode mode) {
    return mode == AppMode.dark ? Colors.grey[300] : const Color(0xFFE0E0E0);
  }

  Color iconInput(AppMode mode) {
    return mode == AppMode.dark ? Colors.grey[300] : Colors.grey;
  }

  Color colorInput(AppMode mode) {
    return mode == AppMode.dark ? Colors.grey[300] : Colors.black;
  }

  Color googleColor(AppMode mode) {
    return mode == AppMode.dark ? Colors.grey[300] : Color(0xFFDB4437);
  }

  Color facebookColor(AppMode mode) {
    return mode == AppMode.dark ? Colors.grey[300] : Color(0xFF3B5998);
  }

  Color textColor(AppMode mode) {
    return mode == AppMode.dark ? Colors.grey[200] : Colors.grey[600];
  }

  Color get textContrastColor => Colors.white;

  Color cardColor(AppMode mode) {
    return mode == AppMode.dark ? const Color(0xFF111820) : Colors.white;
  }

  Color cardSignInColor(AppMode mode) {
    return mode == AppMode.dark ? const Color(0xFF171f29) : Colors.white;
  }

  Color buttonBackgroundColor(AppMode mode) {
    return mode == AppMode.dark
        ? const Color(0xFF022b35)
        : const Color(0xFFDA1993);
  }

  Color appBarColor(AppMode mode) {
    return mode == AppMode.dark ? const Color(0xFFDA1993) : Colors.grey[350];
  }

  Color navigatorBarColor(AppMode mode) {
    return mode == AppMode.dark ? const Color(0xFF111820) : Colors.white;
  }

  Color selectedItemLabelColor(AppMode mode) {
    return mode == AppMode.dark ? Colors.white : Colors.black;
  }

  Color selectedItemColor(AppMode mode) {
    return mode == AppMode.dark ? Color(0xFF1a3d44) : Color(0xFFB41EB3);
  }

  Color get successColor => Colors.teal;
  Color get contrastColor => Colors.black;
}
