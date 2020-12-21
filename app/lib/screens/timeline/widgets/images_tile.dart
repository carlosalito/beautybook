import 'package:beautybook/app_controller.dart';
import 'package:beautybook/core/injectable/injectable.dart';
import 'package:beautybook/screens/timeline/timeline.controller.dart';
import 'package:beautybook/screens/timeline/widgets/galery_zoomable.dart';
import 'package:beautybook/screens/timeline/widgets/image_cover.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagesTile extends StatelessWidget {
  final List<String> images;
  final bool details;
  final List<String> galleryItems;
  final int index;

  final controller = getIt<TimelineController>();
  final appController = getIt<AppController>();

  ImagesTile({this.images, this.details, this.galleryItems, this.index});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return _mosaic(context, images, size);
  }

  Widget _mosaic(BuildContext context, List<String> images, Size size) {
    final double simpleH = 150;
    final double doubleH = 306;
    final double coverW = size.width * 0.5;
    final double doubleCoverW = size.width;

    if (images.length == 1) {
      return GestureDetector(
        onTap: () {
          if (details == true) {
            controller.setIndexPictureShow(index);
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => GaleryZoomable(
                  appMode: appController.appMode,
                  galleryItems: galleryItems,
                  initialIndex: index,
                  scrollDirection: Axis.horizontal,
                  minScale: 0.5,
                  maxScale: 4,
                ),
              ),
            );
          }
        },
        child: ImageCover(
          image: images[0],
          height: simpleH * 1.5,
          width: doubleCoverW,
        ),
      );
    } else if (images.length == 2) {
      return Row(
        children: <Widget>[
          ImageCover(
              image: images[0],
              height: simpleH,
              width: coverW,
              flex: 6,
              right: true),
          ImageCover(
              image: images[1],
              height: simpleH,
              width: coverW,
              flex: 6,
              left: true),
        ],
      );
    } else if (images.length == 3) {
      return Row(
        children: <Widget>[
          ImageCover(
              image: images[0],
              height: doubleH,
              width: coverW,
              flex: 6,
              right: true),
          Expanded(
              flex: 6,
              child: Column(children: <Widget>[
                ImageCover(
                    image: images[1],
                    height: simpleH,
                    width: coverW,
                    left: true,
                    bottom: true),
                ImageCover(
                    image: images[2],
                    height: simpleH,
                    width: coverW,
                    left: true,
                    top: true),
              ]))
        ],
      );
    } else if (images.length == 4) {
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ImageCover(
                  image: images[0],
                  height: simpleH,
                  width: coverW,
                  flex: 6,
                  right: true,
                  bottom: true),
              ImageCover(
                  image: images[1],
                  height: simpleH,
                  width: coverW,
                  flex: 6,
                  left: true,
                  bottom: true),
            ],
          ),
          Row(
            children: <Widget>[
              ImageCover(
                  image: images[2],
                  height: simpleH,
                  width: coverW,
                  flex: 6,
                  right: true,
                  top: true),
              ImageCover(
                  image: images[3],
                  height: simpleH,
                  width: coverW,
                  flex: 6,
                  left: true,
                  top: true),
            ],
          )
        ],
      );
    } else if (images.length >= 5) {
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ImageCover(
                  image: images[0],
                  height: simpleH,
                  width: coverW,
                  flex: 6,
                  right: true,
                  bottom: true),
              ImageCover(
                  image: images[1],
                  height: simpleH,
                  width: coverW,
                  flex: 6,
                  left: true,
                  bottom: true),
            ],
          ),
          Stack(
            alignment: Alignment.centerRight,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ImageCover(
                      image: images[2],
                      height: simpleH,
                      width: coverW,
                      flex: 4,
                      right: true,
                      top: true),
                  ImageCover(
                      image: images[3],
                      height: simpleH,
                      width: coverW,
                      flex: 4,
                      left: true,
                      right: true,
                      top: true),
                  ImageCover(
                      image: images[4],
                      height: simpleH,
                      width: coverW,
                      flex: 4,
                      left: true,
                      top: true),
                ],
              ),
              images.length > 5
                  ? Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 3),
                      height: simpleH,
                      width: size.width * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                      ),
                      child: Text('+${images.length - 4}',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.8))))
                  : Container()
            ],
          )
        ],
      );
    } else {
      return Container();
    }
  }
}
