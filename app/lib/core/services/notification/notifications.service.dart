import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class Notifications {
  static void _showToast(BuildContext context, String message,
      {Color backgroundColor,
      Color primaryColor,
      int duration,
      FlushbarPosition position}) {
    Flushbar(
        messageText: Text(message,
            style:
                TextStyle(color: primaryColor ?? Theme.of(context).errorColor)),
        duration: Duration(seconds: duration ?? 3),
        flushbarPosition: position ?? FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.FLOATING,
        margin: EdgeInsets.all(8),
        isDismissible: true,
        backgroundColor: backgroundColor ?? Theme.of(context).cardColor,
        leftBarIndicatorColor: primaryColor ?? Theme.of(context).errorColor)
      ..show(context);
  }

  static void error({BuildContext context, String message, int duration = 3}) {
    _showToast(context, message,
        backgroundColor: Theme.of(context).errorColor,
        primaryColor: Colors.white,
        duration: duration);
  }

  static void alert({BuildContext context, String message}) {
    _showToast(context, message,
        backgroundColor: Colors.yellow[800], primaryColor: Colors.white);
  }
}
