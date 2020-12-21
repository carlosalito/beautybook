import 'dart:io';

import 'package:beautybook/core/extensions/theme.dart';
import 'package:beautybook/core/icons/beautybook_icons.dart';
import 'package:beautybook/core/models/user/app_mode_enum.dart';
import 'package:beautybook/core/services/notification/notifications.service.dart';
import 'package:beautybook/core/services/utils/utils.services.dart';
import 'package:beautybook/shared_widgets/base_state/base_state.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  final Function(String) onImageSelected;
  final String firebasePath;
  final bool isRemovible;
  final CropAspectRatio aspectRatio;
  final double maxWidth;
  final bool crop;
  final bool sendImmediately;
  final AppMode appMode;

  PickImage({
    @required this.onImageSelected,
    @required this.firebasePath,
    this.isRemovible,
    @required this.crop,
    @required this.sendImmediately,
    this.aspectRatio,
    this.maxWidth = 768.0,
    this.appMode,
  });

  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends BaseState<PickImage> {
  static const _baseTranslate = 'pickImage';
  double _progress = 0;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BottomSheet(
      onClosing: () {},
      builder: (context) => Container(
          height: size.height * .15,
          color: Theme.of(context).colorScheme.cardColor(widget.appMode),
          child: Column(
            children: <Widget>[
              widget.sendImmediately
                  ? Container(
                      child: LinearProgressIndicator(value: _progress),
                    )
                  : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FlatButton(
                        child: Container(
                            padding: EdgeInsets.all(20),
                            height: size.width * .2,
                            child: Icon(BeautybookIcons.iconCam,
                                size: 30,
                                color: Theme.of(context).primaryColor)),
                        onPressed: () async {
                          final bool result =
                              await _processImage(ImageSource.camera);
                          if (!result) {
                            Notifications.error(
                                context: context,
                                message: translate('$_baseTranslate.error'));
                          }
                        },
                      ),
                      Text(translate('$_baseTranslate.cam'))
                    ],
                  ),
                  Column(children: <Widget>[
                    FlatButton(
                      child: Container(
                          padding: EdgeInsets.all(20),
                          height: size.width * .2,
                          child: Icon(BeautybookIcons.iconGalery,
                              size: 30, color: Theme.of(context).primaryColor)),
                      onPressed: () async {
                        final bool result =
                            await _processImage(ImageSource.gallery);
                        if (!result) {
                          Notifications.error(
                              context: context,
                              message: translate('$_baseTranslate.error'));
                        }
                      },
                    ),
                    Text(translate('$_baseTranslate.galery')),
                  ]),
                  widget.isRemovible
                      ? Column(children: <Widget>[
                          FlatButton(
                            child: Container(
                                padding: EdgeInsets.all(20),
                                height: size.width * .2,
                                child: Icon(BeautybookIcons.iconTrash,
                                    size: 30,
                                    color: Theme.of(context).errorColor)),
                            onPressed: () async {
                              widget.onImageSelected(null);
                            },
                          ),
                          Text(
                            translate("$_baseTranslate.remove"),
                          )
                        ])
                      : Container(height: size.height * .1),
                ],
              ),
            ],
          )),
    );
  }

  Future<bool> _processImage(ImageSource source) async {
    try {
      String url;
      setState(() {
        _progress = null;
      });

      final ImagePicker _picker = ImagePicker();
      final PickedFile _imagePicked = await _picker.getImage(
          source: source, maxWidth: widget.maxWidth, imageQuality: 70);
      final File _image = File(_imagePicked.path);

      File croppedImage = _image;
      if (widget.crop) {
        croppedImage = await ImageCropper.cropImage(
            sourcePath: _image.path,
            aspectRatio: widget.aspectRatio,
            compressFormat: ImageCompressFormat.jpg);
      }

      if (widget.sendImmediately) {
        final task =
            UtilsServices.uploadFile(widget.firebasePath, croppedImage);

        task.snapshotEvents.listen((event) async {
          setState(() {
            _progress =
                ((task.snapshot.bytesTransferred / task.snapshot.totalBytes) *
                    100);
          });

          if (event.bytesTransferred >= event.totalBytes &&
              event.state == TaskState.success) {
            String url = await event.ref.getDownloadURL();
            widget.onImageSelected(url);
          }
        }, onError: (e) {
          widget.onImageSelected(null);
        });
      } else {
        url = await UtilsServices.saveTempImage(_image, source);
      }

      widget.onImageSelected(url);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }
}
