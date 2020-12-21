import 'package:beautybook/app_controller.dart';
import 'package:beautybook/core/constants/theme.dart';
import 'package:beautybook/core/extensions/theme.dart';
import 'package:beautybook/core/helpers/i18n/i18n_helper.dart';
import 'package:beautybook/core/helpers/string/string_helper.dart';
import 'package:beautybook/core/injectable/injectable.dart';
import 'package:beautybook/core/models/boticario-news/boticario-news_model.dart';
import 'package:beautybook/screens/boticario-news/boticario_news.controller.dart';
import 'package:beautybook/shared_widgets/circular_avatar/circular_avatar.dart';
import 'package:beautybook/shared_widgets/expandable_text/expandable_text.dart';
import 'package:beautybook/shared_widgets/show_animations/background_unfocus/background_unfocus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class BoticarioNews extends StatefulWidget {
  @override
  _BoticarioNewsState createState() => _BoticarioNewsState();
}

class _BoticarioNewsState extends State<BoticarioNews> {
  final controller = getIt<BoticarioNewsController>();
  final appController = getIt<AppController>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (controller.newsList.length == 0) {
        await controller.list(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SafeArea(
        child: BackgroundUnfocus(
          backgroundColor: Theme.of(context).backgroundColor,
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () => controller.refreshNews(context),
            backgroundColor: Theme.of(context).backgroundColor,
            child: Stack(
              children: <Widget>[
                _loadingNews(),
                ListView.builder(
                  itemCount: controller.newsList.length,
                  itemBuilder: (context, index) =>
                      _newsTile(controller.newsList[index], index),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  double _resolveMarginBottom(int index) {
    return index == controller.newsList.length - 1 ? 25.0 : 0.0;
  }

  Widget _newsTile(BoticarioNewsModel news, int index) {
    return Container(
      padding: EdgeInsets.all(Constants.padding),
      margin: EdgeInsets.only(
          top: 10, left: 7, right: 7, bottom: _resolveMarginBottom(index)),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.cardColor(appController.appMode),
        borderRadius: BorderRadius.circular(Constants.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _newsHeader(news),
          Divider(),
          _newsBody(news),
        ],
      ),
    );
  }

  Widget _newsHeader(BoticarioNewsModel news) {
    return Row(
      children: [
        CircularAvatar(
          size: 35,
          picture: news.user.profilePicture,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              news.user.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              StringHelper.friendlyDate(context, news.message.createdAt),
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Theme.of(context)
                    .colorScheme
                    .textColor(appController.appMode),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _newsBody(BoticarioNewsModel news) {
    return ExpandableText(
      text: news.message.content,
      moreLabel: I18nHelper.translate(context, 'timeline.more'),
      lessLabel: I18nHelper.translate(context, 'timeline.less'),
    );
  }

  Widget _loadingNews() {
    return controller.loading && !controller.refreshing
        ? Container(
            padding: EdgeInsets.only(bottom: Constants.padding),
            child: LinearProgressIndicator(),
          )
        : Container();
  }
}
