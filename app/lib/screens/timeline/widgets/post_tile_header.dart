import 'package:beautybook/core/extensions/theme.dart';
import 'package:beautybook/core/helpers/string/string_helper.dart';
import 'package:beautybook/core/models/post/post_model.dart';
import 'package:beautybook/core/models/user/app_mode_enum.dart';
import 'package:beautybook/shared_widgets/circular_avatar/circular_avatar.dart';
import 'package:flutter/material.dart';

class PostTileHeader extends StatelessWidget {
  final AppMode appMode;
  final PostModel post;

  PostTileHeader({this.appMode, this.post});

  @override
  Widget build(BuildContext context) {
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
                    color: Theme.of(context).colorScheme.textColor(appMode),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
