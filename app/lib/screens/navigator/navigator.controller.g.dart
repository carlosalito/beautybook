// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigator.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NavigatorController on _NavigatorControllerBase, Store {
  final _$pageControllerAtom =
      Atom(name: '_NavigatorControllerBase.pageController');

  @override
  PageController get pageController {
    _$pageControllerAtom.reportRead();
    return super.pageController;
  }

  @override
  set pageController(PageController value) {
    _$pageControllerAtom.reportWrite(value, super.pageController, () {
      super.pageController = value;
    });
  }

  final _$appBarTitleAtom = Atom(name: '_NavigatorControllerBase.appBarTitle');

  @override
  String get appBarTitle {
    _$appBarTitleAtom.reportRead();
    return super.appBarTitle;
  }

  @override
  set appBarTitle(String value) {
    _$appBarTitleAtom.reportWrite(value, super.appBarTitle, () {
      super.appBarTitle = value;
    });
  }

  final _$selectedIndexAtom =
      Atom(name: '_NavigatorControllerBase.selectedIndex');

  @override
  int get selectedIndex {
    _$selectedIndexAtom.reportRead();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.reportWrite(value, super.selectedIndex, () {
      super.selectedIndex = value;
    });
  }

  final _$_NavigatorControllerBaseActionController =
      ActionController(name: '_NavigatorControllerBase');

  @override
  void setSelectedIndex(int index) {
    final _$actionInfo = _$_NavigatorControllerBaseActionController.startAction(
        name: '_NavigatorControllerBase.setSelectedIndex');
    try {
      return super.setSelectedIndex(index);
    } finally {
      _$_NavigatorControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pageController: ${pageController},
appBarTitle: ${appBarTitle},
selectedIndex: ${selectedIndex}
    ''';
  }
}