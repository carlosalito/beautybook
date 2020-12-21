import 'package:beautybook/app_controller.dart';
import 'package:beautybook/core/constants/theme.dart';
import 'package:beautybook/core/extensions/theme.dart';
import 'package:beautybook/core/helpers/i18n/i18n_helper.dart';
import 'package:beautybook/core/helpers/string/string_helper.dart';
import 'package:beautybook/core/icons/beautybook_icons.dart';
import 'package:beautybook/core/injectable/injectable.dart';
import 'package:beautybook/core/models/post/post_model.dart';
import 'package:beautybook/screens/timeline/timeline.controller.dart';
import 'package:beautybook/screens/timeline/widgets/delete_modal.dart';
import 'package:beautybook/screens/timeline/widgets/images_tile.dart';
import 'package:beautybook/shared_widgets/circular_avatar/circular_avatar.dart';
import 'package:beautybook/shared_widgets/expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostTile extends StatelessWidget {
  final PostModel post;
  final int index;

  final appController = getIt<AppController>();
  final controller = getIt<TimelineController>();

  PostTile({this.post, this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(CupertinoPageRoute(
        //     builder: (context) => PostDetailsScreen(post: widget.post)));
      },
      child: Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 10),
        decoration: BoxDecoration(
            color:
                Theme.of(context).colorScheme.cardColor(appController.appMode),
            borderRadius: BorderRadius.circular(7)),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                _postHeader(context),
                Expanded(
                  child: Container(),
                ),
                _postActions(context),
              ],
            ),
            Divider(),
            _postTitle(),
            _postBody(context),
            post.pictures != null && post.pictures.length > 0
                ? ImagesTile(images: post.pictures)
                : Container()
          ],
        ),
      ),
    );
  }

  Widget _postTitle() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(post.title, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _postBody(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 5),
        alignment: Alignment.topLeft,
        child: ExpandableText(
          text: post.body,
          moreLabel: I18nHelper.translate(context, 'timeline.more'),
          lessLabel: I18nHelper.translate(context, 'timeline.less'),
        ));
  }

  Widget _postActions(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 5),
      child: Container(
        child: (appController.user?.uid ?? '') == post.userUid
            ? Row(
                children: <Widget>[
                  _actionButton(
                    context: context,
                    icon: BeautybookIcons.iconEdit,
                    iconColor: Theme.of(context).primaryColor,
                    action: () => controller.editPost(post),
                  ),
                  SizedBox(width: Constants.doublePadding),
                  _actionButton(
                    context: context,
                    icon: BeautybookIcons.iconTrash,
                    iconColor: Theme.of(context).errorColor,
                    action: () => _deletePost(context),
                  ),
                ],
              )
            : Container(),
      ),
    );
  }

  Widget _actionButton(
      {BuildContext context, Function action, IconData icon, Color iconColor}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: action,
        child: Icon(icon, color: iconColor),
      ),
    );
  }

  Widget _postHeader(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          CircularAvatar(
            size: 35,
            picture: post.userPicture,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 7),
                child: Text(
                  post.userName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 7),
                child: Text(
                  StringHelper.friendlyDate(context, post.createdAt),
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context)
                        .colorScheme
                        .textColor(appController.appMode),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // _edit(TimelineService timelineService) {
  //   timelineService.timelineProvider.setGalery(widget.post.pictures);
  //   Navigator.of(context).push(CupertinoPageRoute(
  //       builder: (context) =>
  //           PostScreen(post: widget.post, index: widget.index)));
  // }

  // bool _canEdit() {
  //   UtilsService utils = UtilsService();
  //   final UserModel user = utils.getValueInBox(Storage.user);
  //   if (user != null && user.uid == widget.post.userUid) {
  //     return true;
  //   }
  //   return false;
  // }

  void _deletePost(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return BottomSheet(
                onClosing: () => controller.setDeleteState(false),
                builder: (context) {
                  return DeleteModal(
                    post: post,
                  );
                });
          });
        });
  }
}
