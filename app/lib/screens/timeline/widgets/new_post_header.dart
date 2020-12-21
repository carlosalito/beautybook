import 'package:beautybook/app_controller.dart';
import 'package:beautybook/core/extensions/theme.dart';
import 'package:beautybook/core/helpers/i18n/i18n_helper.dart';
import 'package:beautybook/core/helpers/theme/theme_helper.dart';
import 'package:beautybook/core/icons/beautybook_icons.dart';
import 'package:beautybook/core/injectable/injectable.dart';
import 'package:beautybook/screens/timeline/timeline.controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewPostHeader extends StatelessWidget {
  final appController = getIt<AppController>();
  final controller = getIt<TimelineController>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
        width: size.width,
        margin: EdgeInsets.only(top: 10, left: 7, right: 7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color:
                Theme.of(context).colorScheme.cardColor(appController.appMode),
            boxShadow: [ThemeHelper.boxCard(context)]),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: InkWell(
            onTap: () {
              controller.formPost(null);
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Icon(BeautybookIcons.iconNewPost,
                      color: Theme.of(context).accentColor),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      I18nHelper.translate(context, 'post.new'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
