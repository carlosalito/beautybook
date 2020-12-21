import 'dart:async';

import 'package:beautybook/core/constants/globals.dart';
import 'package:beautybook/core/constants/storage.dart';
import 'package:beautybook/core/constants/theme.dart';
import 'package:beautybook/core/helpers/hive/hive_helper.dart';
import 'package:beautybook/core/helpers/i18n/i18n_helper.dart';
import 'package:beautybook/core/models/user/user_model.dart';
import 'package:beautybook/core/repositories/user_repository.dart';
import 'package:beautybook/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'app_controller.g.dart';

@singleton
class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  AuthService authService;
  UserRepository userRepository;

  _AppControllerBase({this.authService, this.userRepository});

  @observable
  UserModel user;

  @observable
  ThemeData theme = lightTheme;

  @observable
  AppMode appMode = AppMode.light;

  @observable
  Language language = Language.portuguese;

  @action
  void setTheme(AppMode value) {
    appMode = value ?? AppMode.light;
    if (value == AppMode.dark) theme = darkTheme;
  }

  @action
  void toggleAppMode() {
    appMode = appMode == AppMode.light ? AppMode.dark : AppMode.light;
    theme = appMode == AppMode.light ? lightTheme : darkTheme;
    HiveHelper.saveValueInBox(Storage.appMode, appMode);
  }

  @action
  Future<void> loadCurrentUser({UserModel userCreated}) async {
    if (user != null) {
      return;
    }
    user = await authService.currentUser();
  }

  @action
  Future<void> signOut() async {
    await authService.signOut();
    user = null;
  }

  @action
  Future<void> changeLanguage(BuildContext context, Language value) async {
    await FlutterI18n.refresh(context, I18nHelper.getLocale(value));
    language = value;
    HiveHelper.saveValueInBox(Storage.language, language);
  }

  @action
  void setUserPicture(String picture) {
    final _user = user.toJson();
    _user['picture'] = picture;
    user = UserModel.fromJson(_user);
    HiveHelper.saveValueInBox(Storage.user, user);
  }
}
