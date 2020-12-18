import 'package:beautybook/core/models/user/app_mode_enum.dart';
import 'package:flutter/material.dart';

final Color primaryBase = Color(0xFF072852);

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
    return mode == AppMode.dark ? const Color(0xFF034150) : Colors.white;
  }

  Color appBarColor(AppMode mode) {
    return mode == AppMode.dark ? const Color(0xFF034150) : Colors.grey[350];
  }

  Color get successColor => Colors.teal;
  Color get contrastColor => Colors.black;
}
