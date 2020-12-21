import 'package:beautybook/app_controller.dart';
import 'package:beautybook/core/constants/theme.dart';
import 'package:beautybook/core/extensions/theme.dart';
import 'package:beautybook/core/icons/beautybook_icons.dart';
import 'package:beautybook/core/injectable/injectable.dart';
import 'package:beautybook/core/models/user/app_mode_enum.dart';
import 'package:beautybook/screens/boticario-news/boticario_news_screen.dart';
import 'package:beautybook/screens/navigator/navigator.controller.dart';
import 'package:beautybook/screens/navigator/widgets/header.dart';
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
      Container(),
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
            _profileAction(),
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
            barBackgroundColor: Colors.white,
            selectedItemBorderColor: Theme.of(context).primaryColor,
            selectedItemBackgroundColor: Theme.of(context).primaryColor,
            selectedItemIconColor: Colors.white,
            selectedItemLabelColor: Theme.of(context).primaryColorDark,
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
              label: 'Posts',
            ),
            FFNavigationBarItem(
              iconData: BeautybookIcons.boticario,
              label: 'Novidades',
            ),
            FFNavigationBarItem(
              iconData: BeautybookIcons.iconProfile,
              label: 'Perfil',
            ),
          ],
        ),
      );
    });
  }

  Widget _profileAction() {
    return Padding(
        padding: EdgeInsets.only(right: Constants.padding * .5),
        child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            // if (userServices.userProvider.user != null &&
            //     userServices.userProvider.user.uid != '') {
            //   Navigator.pushNamed(context, Routes.profile);
            // } else {
            //   Navigator.pushNamedAndRemoveUntil(
            //       context, Routes.signin, (Route<dynamic> route) => false);
            // }
          },
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

  Future<void> _signOut() async {
    // try {
    //   setState(() {
    //     loading = true;
    //   });
    //   await appController.signOut();
    //   ExtendedNavigator.root.popAndPush(Routes.signInScreen);
    //   setState(() {
    //     loading = true;
    //   });
    // } catch (e) {
    //   Notifications.error(context: context, message: 'Erro ao realizar logout');
    //   setState(() {
    //     loading = true;
    //   });
    //   throw (e);
    // }
  }
}
