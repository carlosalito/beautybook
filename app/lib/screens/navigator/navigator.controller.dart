import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'navigator.controller.g.dart';

@injectable
class NavigatorController = _NavigatorControllerBase with _$NavigatorController;

abstract class _NavigatorControllerBase with Store {
  static const titles = [
    'Veículos Disponíveis',
    'Veículos Vendidos',
    'Perfil do Usuário'
  ];

  @observable
  PageController pageController = PageController(initialPage: 0);

  @observable
  String appBarTitle = titles[0];

  @observable
  int selectedIndex = 0;

  @action
  void setSelectedIndex(int index) {
    selectedIndex = index;
    appBarTitle = titles[index];
    pageController.animateToPage(index,
        curve: Curves.ease, duration: Duration(milliseconds: 500));
  }
}
