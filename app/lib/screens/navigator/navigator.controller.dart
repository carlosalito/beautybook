import 'package:auto_route/auto_route.dart';
import 'package:beautybook/app_controller.dart';
import 'package:beautybook/core/helpers/i18n/i18n_helper.dart';
import 'package:beautybook/core/router/router.gr.dart';
import 'package:beautybook/core/services/notification/notifications.service.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'navigator.controller.g.dart';

@injectable
class NavigatorController = _NavigatorControllerBase with _$NavigatorController;

abstract class _NavigatorControllerBase with Store {
  AppController appController;

  _NavigatorControllerBase({this.appController});

  @observable
  PageController pageController = PageController(initialPage: 0);

  @observable
  int selectedIndex = 0;

  @action
  void setSelectedIndex(int index) {
    selectedIndex = index;
    pageController.animateToPage(index,
        curve: Curves.ease, duration: Duration(milliseconds: 500));
  }

  @action
  void profileAction() {
    if (appController.user != null && appController.user.uid != null)
      setSelectedIndex(2);
    else
      ExtendedNavigator.root.popAndPush(Routes.signInScreen);
  }

  @action
  Future<void> signOut(BuildContext context) async {
    try {
      await appController.signOut();
      ExtendedNavigator.root.popAndPush(Routes.signInScreen);
    } catch (e) {
      Notifications.error(
        context: context,
        message: I18nHelper.translate(context, 'navigator.signoutError'),
      );
    }
  }
}
