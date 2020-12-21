import 'package:beautybook/app_controller.dart';
import 'package:beautybook/core/constants/globals.dart';
import 'package:beautybook/core/extensions/theme.dart';
import 'package:beautybook/core/helpers/i18n/i18n_helper.dart';
import 'package:beautybook/core/helpers/theme/theme_helper.dart';
import 'package:beautybook/core/injectable/injectable.dart';
import 'package:beautybook/core/models/post/post_model.dart';
import 'package:beautybook/screens/timeline/timeline.controller.dart';
import 'package:beautybook/screens/timeline/widgets/images_tile.dart';
import 'package:beautybook/screens/timeline/widgets/post_tile_header.dart';
import 'package:flutter/material.dart';

class PostDetailsScreen extends StatelessWidget {
  final PostModel post;
  final appController = getIt<AppController>();
  final controller = getIt<TimelineController>();

  PostDetailsScreen({this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: appController.appMode == AppMode.dark
              ? Brightness.dark
              : Brightness.light,
          iconTheme: Theme.of(context).iconTheme,
          actionsIconTheme: Theme.of(context).iconTheme,
          title: Text(
            I18nHelper.translate(context, 'post.title'),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          backgroundColor:
              Theme.of(context).colorScheme.cardColor(appController.appMode),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 25),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .cardColor(appController.appMode),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [ThemeHelper.boxCard(context)]),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    PostTileHeader(appMode: appController.appMode, post: post),
                    SizedBox(
                      height: 10,
                    ),
                    Text(post.title,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Divider(),
                    Text(
                      post.body,
                    ),
                    if (post.pictures != null && post.pictures.length > 0)
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: post.pictures.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: ImagesTile(
                              details: true,
                              galleryItems: post.pictures,
                              index: index,
                              images: [post.pictures[index]],
                            ),
                          );
                        },
                      )
                  ])),
        )));
  }
}
