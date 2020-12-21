// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppController on _AppControllerBase, Store {
  final _$userAtom = Atom(name: '_AppControllerBase.user');

  @override
  UserModel get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$themeAtom = Atom(name: '_AppControllerBase.theme');

  @override
  ThemeData get theme {
    _$themeAtom.reportRead();
    return super.theme;
  }

  @override
  set theme(ThemeData value) {
    _$themeAtom.reportWrite(value, super.theme, () {
      super.theme = value;
    });
  }

  final _$appModeAtom = Atom(name: '_AppControllerBase.appMode');

  @override
  AppMode get appMode {
    _$appModeAtom.reportRead();
    return super.appMode;
  }

  @override
  set appMode(AppMode value) {
    _$appModeAtom.reportWrite(value, super.appMode, () {
      super.appMode = value;
    });
  }

  final _$languageAtom = Atom(name: '_AppControllerBase.language');

  @override
  Language get language {
    _$languageAtom.reportRead();
    return super.language;
  }

  @override
  set language(Language value) {
    _$languageAtom.reportWrite(value, super.language, () {
      super.language = value;
    });
  }

  final _$loadCurrentUserAsyncAction =
      AsyncAction('_AppControllerBase.loadCurrentUser');

  @override
  Future<void> loadCurrentUser({UserModel userCreated}) {
    return _$loadCurrentUserAsyncAction
        .run(() => super.loadCurrentUser(userCreated: userCreated));
  }

  final _$signOutAsyncAction = AsyncAction('_AppControllerBase.signOut');

  @override
  Future<void> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  final _$changeLanguageAsyncAction =
      AsyncAction('_AppControllerBase.changeLanguage');

  @override
  Future<void> changeLanguage(BuildContext context, Language value) {
    return _$changeLanguageAsyncAction
        .run(() => super.changeLanguage(context, value));
  }

  final _$_AppControllerBaseActionController =
      ActionController(name: '_AppControllerBase');

  @override
  void setTheme(AppMode value) {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase.setTheme');
    try {
      return super.setTheme(value);
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleAppMode() {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase.toggleAppMode');
    try {
      return super.toggleAppMode();
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserPicture(String picture) {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase.setUserPicture');
    try {
      return super.setUserPicture(picture);
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
theme: ${theme},
appMode: ${appMode},
language: ${language}
    ''';
  }
}
