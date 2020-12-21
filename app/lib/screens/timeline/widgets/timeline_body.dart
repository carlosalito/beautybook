import 'package:beautybook/core/constants/theme.dart';
import 'package:beautybook/core/helpers/i18n/i18n_helper.dart';
import 'package:beautybook/core/injectable/injectable.dart';
import 'package:beautybook/screens/timeline/timeline.controller.dart';
import 'package:beautybook/screens/timeline/widgets/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TimelineBody extends StatelessWidget {
  final controller = getIt<TimelineController>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 10, left: 7, right: 7, bottom: 45),
        child: Column(
          children: <Widget>[
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.postList.length,
                itemBuilder: (context, index) {
                  return PostTile(
                      post: controller.postList[index], index: index);
                }),
            _resolveLoading(),
            _endPostsList(context),
          ],
        ),
      );
    });
  }

  Widget _resolveLoading() {
    return controller.loading && !controller.refreshing
        ? Container(
            margin: EdgeInsets.only(bottom: Constants.padding),
            child: CircularProgressIndicator(),
          )
        : Container();
  }

  _endPostsList(BuildContext context) {
    if (controller.page == controller.pageInfo.totalPages - 1) {
      return Container(
          child: Text(
        I18nHelper.translate(context, 'timeline.endList'),
        style: TextStyle(fontWeight: FontWeight.bold),
      ));
    }
    return Container();
  }
}
