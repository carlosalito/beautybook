import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageCover extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final int flex;
  final bool left;
  final bool right;
  final bool top;
  final bool bottom;

  ImageCover(
      {this.image,
      this.width,
      this.height,
      this.flex,
      this.bottom,
      this.left,
      this.right,
      this.top});

  @override
  Widget build(BuildContext context) {
    return flex == null
        ? _containerImage()
        : Expanded(flex: flex, child: _containerImage());
  }

  Widget _containerImage() {
    return Container(
      margin: EdgeInsets.only(
        right: right == true ? 3 : 0,
        left: left == true ? 3 : 0,
        top: top == true ? 3 : 0,
        bottom: bottom == true ? 3 : 0,
      ),
      child: image.startsWith('https://')
          ? CachedNetworkImage(
              imageUrl: image,
              height: height,
              width: width,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            )
          : Image.file(File(image)),
    );
  }
}
