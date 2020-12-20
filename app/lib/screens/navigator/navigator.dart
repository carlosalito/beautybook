import 'package:beautybook/app_controller.dart';
import 'package:beautybook/core/icons/beautybook_icons.dart';
import 'package:beautybook/core/injectable/injectable.dart';
import 'package:beautybook/screens/navigator/navigator.controller.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class NavigatorScreen extends StatefulWidget {
  @override
  _NavigatorScreenState createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  final controller = getIt<NavigatorController>();
  final appController = getIt<AppController>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Container(),
      Container(),
      Container(),
    ];

    return Observer(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(controller.appBarTitle),
          actions: [],
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
