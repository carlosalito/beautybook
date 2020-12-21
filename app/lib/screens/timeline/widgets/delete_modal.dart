import 'package:beautybook/core/constants/theme.dart';
import 'package:beautybook/core/helpers/i18n/i18n_helper.dart';
import 'package:beautybook/core/icons/beautybook_icons.dart';
import 'package:beautybook/core/injectable/injectable.dart';
import 'package:beautybook/core/models/post/post_model.dart';
import 'package:beautybook/screens/timeline/timeline.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class DeleteModal extends StatefulWidget {
  final PostModel post;

  DeleteModal({this.post});

  @override
  _DeleteModalState createState() => _DeleteModalState();
}

class _DeleteModalState extends State<DeleteModal> {
  final controller = getIt<TimelineController>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Container(
        height: 90,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _loadingDelete(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _deleteButton(
                  context: context,
                  action: () async {
                    await controller.deletePost(context, widget.post);
                    Navigator.pop(context);
                  },
                  icon: BeautybookIcons.iconTrash,
                  iconColor: Theme.of(context).disabledColor,
                  label: I18nHelper.translate(context, 'post.delete.confirm'),
                  labelColor: Theme.of(context).disabledColor,
                ),
                _deleteButton(
                  context: context,
                  action: () async {
                    controller.setDeleteState(false);
                    Navigator.pop(context);
                  },
                  icon: BeautybookIcons.iconCancel,
                  iconColor: Theme.of(context).primaryColor,
                  label: I18nHelper.translate(context, 'post.delete.cancel'),
                  labelColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _loadingDelete() {
    return controller.deleting == true
        ? Container(
            padding: EdgeInsets.only(bottom: Constants.doublePadding),
            child: LinearProgressIndicator(),
          )
        : Container(
            padding: EdgeInsets.only(top: Constants.doublePadding),
          );
  }

  Widget _deleteButton(
      {BuildContext context,
      Function action,
      IconData icon,
      Color iconColor,
      String label,
      Color labelColor}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: action,
        child: Column(
          children: <Widget>[
            Icon(icon, color: iconColor),
            SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(color: labelColor),
            )
          ],
        ),
      ),
    );
  }
}
