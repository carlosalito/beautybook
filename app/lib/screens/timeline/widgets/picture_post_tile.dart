import 'dart:io';

import 'package:beautybook/app_controller.dart';
import 'package:beautybook/core/constants/theme.dart';
import 'package:beautybook/core/icons/beautybook_icons.dart';
import 'package:beautybook/core/injectable/injectable.dart';
import 'package:beautybook/screens/timeline/timeline.controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PicturePostTile extends StatelessWidget {
  final String url;
  final int index;
  final String postUid;

  PicturePostTile({this.index, this.url, this.postUid});

  final appController = getIt<AppController>();
  final controller = getIt<TimelineController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 95,
          height: 95,
          margin: EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Constants.borderRadius),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: url.startsWith('https://')
                    ? CachedNetworkImageProvider(url)
                    : FileImage(
                        File(url),
                      ),
              )),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: GestureDetector(
            onTap: () => controller.deleteFile(context, index, postUid),
            child: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Theme.of(context).errorColor),
              child: Icon(BeautybookIcons.iconTrash,
                  color: Colors.white, size: 17),
            ),
          ),
        )
      ],
    );
  }
}
