import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:beautybook/app_controller.dart';
import 'package:beautybook/core/constants/storage.dart';
import 'package:beautybook/core/helpers/hive/hive_helper.dart';
import 'package:beautybook/core/helpers/i18n/i18n_helper.dart';
import 'package:beautybook/core/models/user/user_model.dart';
import 'package:beautybook/core/models/user/user_response_enum.dart';
import 'package:beautybook/core/repositories/user_repository.dart';
import 'package:beautybook/core/router/router.gr.dart';
import 'package:beautybook/core/services/account/accounts_service.dart';
import 'package:beautybook/core/services/auth/auth_service.dart';
import 'package:beautybook/core/services/notification/notifications.service.dart';
import 'package:beautybook/core/services/utils/utils.services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'signup.controller.g.dart';

@injectable
class SignUpController = _SignUpControllerBase with _$SignUpController;

abstract class _SignUpControllerBase with Store {
  AppController appController;
  AccountService accountService;
  UserRepository repository;
  AuthService authService;

  _SignUpControllerBase({
    this.appController,
    this.accountService,
    this.repository,
    this.authService,
  });

  @observable
  bool loading = false;

  @observable
  String error;

  @observable
  var formKey = GlobalKey<FormState>();

  @observable
  TextEditingController nameController = TextEditingController();

  @observable
  TextEditingController emailController = TextEditingController();

  @observable
  TextEditingController passwordController = TextEditingController();

  @observable
  String picture;

  @action
  dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
  }

  @action
  setLoading(bool value) {
    loading = value;
  }

  @action
  setPicture(String value) {
    picture = value;
  }

  @action
  UploadTask uploadProfileImage(String path) {
    final Uri _uri = Uri.file(picture);
    final File _file = File.fromUri(_uri);

    return UtilsServices.uploadFileAndGetUrl(path, _file);
  }

  @action
  Future<void> createUser(BuildContext context) async {
    if (formKey.currentState.validate()) {
      try {
        setLoading(true);
        FocusScope.of(context).requestFocus(FocusNode());

        String _picture;
        final _uid = UtilsServices.uId();

        if (picture != null && picture.startsWith('/')) {
          _picture = '${Storage.firebaseStorageUsers}/$_uid.jpg';
          final _task = uploadProfileImage(_picture);

          _task.snapshotEvents.listen((event) async {
            if (event.bytesTransferred >= event.totalBytes &&
                event.state == TaskState.success) {
              await _persistUser(
                context: context,
                picture: _picture,
                uid: _uid,
              );
            }
          }, onError: (e) {
            Notifications.error(
              context: context,
              message: I18nHelper.translate(context, 'signUp.error'),
            );
          });
        } else {
          await _persistUser(
            context: context,
            picture: _picture,
            uid: _uid,
          );
        }
      } catch (e) {
        print(e);
        Notifications.error(
          context: context,
          message: I18nHelper.translate(context, 'signUp.error'),
        );
      }
    }
  }

  Future<void> _persistUser(
      {BuildContext context, String uid, String picture}) async {
    final UserModel _user = new UserModel(
      uid: uid,
      email: emailController.text,
      name: nameController.text,
      password: passwordController.text,
      picture: picture,
    );

    final _result = await repository.create(_user) as UserResponseEnum;

    if (_result == UserResponseEnum.success) {
      await _signIn();
      await appController.loadCurrentUser();
      await _persistToken();
      setLoading(false);
      HiveHelper.saveValueInBox(Storage.user, _user);
      ExtendedNavigator.root.popAndPush(Routes.navigatorScreen);
    } else if (_result == UserResponseEnum.userExist) {
      Notifications.alert(
        context: context,
        message: I18nHelper.translate(context, 'signUp.userExist'),
      );
    } else {
      Notifications.error(
        context: context,
        message: I18nHelper.translate(context, 'signUp.error'),
      );
    }
  }

  Future<void> _persistToken() async {
    final _token = await authService.refreshToken();
    HiveHelper.saveValueInBox(Storage.lastTokenTime, DateTime.now());
    HiveHelper.saveValueInBox(Storage.token, _token);
  }

  Future<void> _signIn() async {
    await authService.signIn(
      email: emailController.text.trim(),
      password: passwordController.text,
    );
  }
}
