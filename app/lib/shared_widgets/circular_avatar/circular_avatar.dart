import 'dart:io';

import 'package:beautybook/core/extensions/theme.dart';
import 'package:beautybook/core/icons/beautybook_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularAvatar extends StatelessWidget {
  final String picture;
  final double size;
  final bool noCache;

  CircularAvatar({this.picture, this.size, this.noCache});

  @override
  Widget build(BuildContext context) {
    return picture == null
        ? Icon(BeautybookIcons.iconProfile,
            size: size * 0.9, color: Theme.of(context).accentColor)
        : picture.startsWith('https://')
            ? Container(
                height: size,
                width: size,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(size),
                  child: CachedNetworkImage(
                    imageUrl: picture,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Icon(BeautybookIcons.iconUser),
                  ),
                ),
              )
            : picture.startsWith('/')
                ? Container(
                    height: size,
                    width: size,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(
                          File(picture),
                        ),
                      ),
                    ),
                  )
                : Container(
                    width: size,
                    height: size,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      picture,
                      style: TextStyle(
                          fontSize: 0.4 * size,
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).colorScheme.textContrastColor),
                    ),
                  );
  }
}
