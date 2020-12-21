import 'package:beautybook/core/helpers/i18n/i18n_helper.dart';
import 'package:beautybook/core/models/boticario-news/boticario-news_model.dart';
import 'package:beautybook/core/repositories/api/api_boticario_news.dart';
import 'package:beautybook/core/services/notification/notifications.service.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'boticario_news.controller.g.dart';

@injectable
class BoticarioNewsController = _BoticarioNewsControllerBase
    with _$BoticarioNewsController;

abstract class _BoticarioNewsControllerBase with Store {
  ApiBoticarioNewsRepository repository;

  _BoticarioNewsControllerBase({this.repository});

  @observable
  List<BoticarioNewsModel> newsList = [];

  @observable
  bool loading = false;

  @observable
  bool refreshing = false;

  @action
  void setLoading(bool value) {
    loading = value;
  }

  @action
  void setRefreshing(bool value) {
    refreshing = value;
  }

  @action
  Future<void> refreshNews(BuildContext context) async {
    setRefreshing(true);
    await list(context);
    setRefreshing(false);
  }

  @action
  Future<void> list(BuildContext context) async {
    try {
      setLoading(true);
      newsList = await repository.list();
      setLoading(false);
    } catch (e) {
      setLoading(false);
      Notifications.error(
        context: context,
        message: I18nHelper.translate(context, 'boticarioNews.error'),
      );
    }
  }
}
