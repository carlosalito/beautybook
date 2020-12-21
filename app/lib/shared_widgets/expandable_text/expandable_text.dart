import 'dart:ui';

import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final String moreLabel;
  final String lessLabel;
  ExpandableText({this.text, this.moreLabel, this.lessLabel});

  @override
  _ExpandableTextState createState() => new _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin<ExpandableText> {
  bool _isExpanded = false;
  static const defaultLines = 5;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      final span = TextSpan(
        text: widget.text,
      );
      final tp = TextPainter(
          text: span, textDirection: TextDirection.ltr, maxLines: defaultLines);
      tp.layout(maxWidth: size.maxWidth);

      if (tp.didExceedMaxLines) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AnimatedSize(
                vsync: this,
                duration: Duration(milliseconds: 250),
                child: Text(
                  widget.text,
                  maxLines: _isExpanded ? null : defaultLines,
                )),
            Container(
              padding: EdgeInsets.only(top: 10),
              alignment: Alignment.topRight,
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _handleOnTap,
                    child: Text(
                      _isExpanded ? widget.lessLabel : widget.moreLabel,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  )),
            )
          ],
        );
      } else {
        return Text(widget.text);
      }
    });
  }

  void _handleOnTap() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
}
