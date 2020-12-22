import 'package:beautybook/app_controller.dart';
import 'package:beautybook/core/constants/globals.dart';
import 'package:beautybook/core/constants/theme.dart';
import 'package:beautybook/core/extensions/theme.dart';
import 'package:beautybook/core/icons/beautybook_icons.dart';
import 'package:beautybook/core/injectable/injectable.dart';
import 'package:beautybook/screens/boticario-news/boticario_news_screen.dart';
import 'package:beautybook/screens/navigator/navigator.controller.dart';
import 'package:beautybook/screens/navigator/widgets/header.dart';
import 'package:beautybook/screens/profile/profile.dart';
import 'package:beautybook/screens/timeline/timeline_screen.dart';
import 'package:beautybook/shared_widgets/base_state/base_state.dart';
import 'package:beautybook/shared_widgets/circular_avatar/circular_avatar.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class NavigatorScreen extends StatefulWidget {
  @override
  _NavigatorScreenState createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends BaseState<NavigatorScreen> {
  static const _baseTranslate = 'navigator';
  final controller = getIt<NavigatorController>();
  final appController = getIt<AppController>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      TimelineScreen(),
      BoticarioNews(),
      ProfileScreen(),
    ];

    return Observer(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          brightness: appController.appMode == AppMode.dark
              ? Brightness.dark
              : Brightness.light,
          iconTheme: Theme.of(context).iconTheme,
          actionsIconTheme: Theme.of(context).iconTheme,
          backgroundColor:
              Theme.of(context).colorScheme.cardColor(appController.appMode),
          title: NavigatorHeader(),
          actions: [
            controller.selectedIndex == 2
                ? _signOutAction(context)
                : _profileAction(),
            _updateMobx(),
          ],
        ),
        body: SafeArea(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: controller.pageController,
            children: pages,
          ),
        ),
        bottomNavigationBar: FFNavigationBar(
          theme: FFNavigationBarTheme(
            barBackgroundColor: Theme.of(context)
                .colorScheme
                .navigatorBarColor(appController.appMode),
            selectedItemBorderColor: Theme.of(context)
                .colorScheme
                .selectedItemColor(appController.appMode),
            selectedItemBackgroundColor: Theme.of(context)
                .colorScheme
                .selectedItemColor(appController.appMode),
            selectedItemIconColor: Colors.white,
            selectedItemLabelColor: Theme.of(context)
                .colorScheme
                .selectedItemLabelColor(appController.appMode),
            showSelectedItemShadow: true,
            barHeight: 65,
          ),
          selectedIndex: controller.selectedIndex,
          onSelectTab: (index) {
            controller.setSelectedIndex(index);
          },
          items: [
            FFNavigationBarItem(
              iconData: BeautybookIcons.iconNewPost,
              label: translate('$_baseTranslate.buttons.posts'),
            ),
            FFNavigationBarItem(
              iconData: BeautybookIcons.boticario,
              label: translate('$_baseTranslate.buttons.news'),
            ),
            if (appController.user != null && appController.user.uid != null)
              FFNavigationBarItem(
                iconData: BeautybookIcons.iconProfile,
                label: translate('$_baseTranslate.buttons.profile'),
              ),
          ],
        ),
      );
    });
  }

  Widget _updateMobx() {
    return Text(
      appController.language.toString(),
      style: TextStyle(fontSize: 0),
    );
  }

  Widget _profileAction() {
    return Padding(
        padding: EdgeInsets.only(right: Constants.padding * .5),
        child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () => controller.profileAction(),
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                  appController.user != null && appController.user.uid != ''
                      ? ''
                      : translate('$_baseTranslate.noLogged'),
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              SizedBox(width: Constants.padding * 0.5),
              appController.user != null
                  ? CircularAvatar(
                      size: 35,
                      picture: appController.user.picture,
                    )
                  : Icon(BeautybookIcons.iconProfile,
                      color: Theme.of(context).primaryColor)
            ],
          ),
        ));
  }

  Widget _signOutAction(BuildContext context) {
    return FlatButton(
      onPressed: () => controller.signOut(context),
      child: Icon(
        BeautybookIcons.iconLogOut,
        size: 20,
        color: Theme.of(context).iconTheme.color,
      ),
    );
  }
}
