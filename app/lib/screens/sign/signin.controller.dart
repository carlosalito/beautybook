import 'package:auto_route/auto_route.dart';
import 'package:beautybook/app_controller.dart';
import 'package:beautybook/core/constants/storage.dart';
import 'package:beautybook/core/helpers/hive/hive_helper.dart';
import 'package:beautybook/core/repositories/user_repository.dart';
import 'package:beautybook/core/router/router.gr.dart';
import 'package:beautybook/core/services/account/accounts_service.dart';
import 'package:beautybook/core/services/notification/notifications.service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'signin.controller.g.dart';

@injectable
class SignInController = _SignInControllerBase with _$SignInController;

abstract class _SignInControllerBase with Store {
  AppController appController;
  AccountService accountService;
  UserRepository repository;

  _SignInControllerBase(
      {this.appController, this.accountService, this.repository});

  BuildContext context;

  @observable
  bool loading = false;

  @observable
  String error;

  @observable
  var formKey = GlobalKey<FormState>();

  @observable
  TextEditingController emailController = TextEditingController();

  @observable
  FocusNode emailFocus = FocusNode();

  @observable
  TextEditingController passwordController = TextEditingController();

  @observable
  FocusNode passwordFocus = FocusNode();

  @observable
  bool obscureText = true;

  @action
  dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  @action
  void setContext(BuildContext _context) {
    context = _context;
  }

  @action
  void toggleObscureText() {
    obscureText = !obscureText;
  }

  @action
  void setLoading(bool value, {String errorMessage}) {
    loading = value;
  }

  Future<void> signIn(BuildContext context) async {
    if (formKey.currentState.validate()) {
      setLoading(true);
      FocusScope.of(context).requestFocus(FocusNode());
      try {
        final _user = await accountService.authenticate(
          email: emailController.text.trim(),
          password: passwordController.text,
        );

        if (_user != null) {
          await appController.loadCurrentUser();
          HiveHelper.saveValueInBox(Storage.user, _user);
          ExtendedNavigator.root.popAndPush(Routes.navigatorScreen);
        } else {
          Notifications.error(
              context: context, message: 'Usuário ou senha inválidos');
        }
        setLoading(false);
      } catch (e) {
        print(e);
        Notifications.error(
            context: context, message: 'Erro ao realizar login');
        setLoading(false);
        throw (e);
      }
    }
  }

  @action
  void signUp() {
    ExtendedNavigator.root.push(Routes.signUpScreen);
  }
}
