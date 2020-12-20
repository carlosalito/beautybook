import 'package:flutter/material.dart';

class BackgroundUnfocus extends StatelessWidget {
  final Widget child;
  final Alignment alignment;
  final Color backgroundColor;

  BackgroundUnfocus(
      {@required this.child, this.alignment, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          alignment: alignment,
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          color: backgroundColor,
          child: child,
        ),
      );
    });
  }
}
