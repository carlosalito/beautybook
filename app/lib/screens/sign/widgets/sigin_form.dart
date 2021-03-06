import 'package:beautybook/app_controller.dart';
import 'package:beautybook/core/constants/globals.dart';
import 'package:beautybook/core/constants/theme.dart';
import 'package:beautybook/core/extensions/theme.dart';
import 'package:beautybook/core/helpers/string/string_helper.dart';
import 'package:beautybook/core/helpers/theme/theme_helper.dart';
import 'package:beautybook/core/icons/beautybook_icons.dart';
import 'package:beautybook/core/injectable/injectable.dart';
import 'package:beautybook/core/models/user/login_provider_enum.dart';
import 'package:beautybook/screens/sign/signin.controller.dart';
import 'package:beautybook/shared_widgets/base_state/base_state.dart';
import 'package:beautybook/shared_widgets/show_animations/showup_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SignInForm extends StatefulWidget {
  final AppMode appMode;

  SignInForm({this.appMode});
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends BaseState<SignInForm> {
  final appController = getIt<AppController>();
  final controller = getIt<SignInController>();
  static const _baseTranslate = 'signin';

  bool obscureText = true;
  final FocusNode _userFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    obscureText = true;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _inputEmail(),
                  _divider(),
                  _passwordInput(),
                  _divider(),
                  _enterButton(),
                  _orWidget(),
                  _socialButtons(),
                ],
              )),
        ),
      );
    });
  }

  Widget _socialButtons() {
    return ShowUp(
      delay: 1000,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 60,
            alignment: Alignment.centerLeft,
            child: FlatButton(
              onPressed: () =>
                  controller.socialLogin(context, LoginProvider.google),
              padding: EdgeInsets.all(0),
              color: Colors.transparent,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Constants.borderRadius)),
              child: Icon(
                BeautybookIcons.iconGoogle,
                color:
                    Theme.of(context).colorScheme.googleColor(widget.appMode),
                size: 30,
              ),
            ),
          ),
          Container(
            width: 60,
            child: FlatButton(
              onPressed: () =>
                  controller.socialLogin(context, LoginProvider.facebook),
              padding: EdgeInsets.all(0),
              color: Colors.transparent,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Constants.borderRadius)),
              child: Icon(
                BeautybookIcons.iconFacebook,
                color:
                    Theme.of(context).colorScheme.facebookColor(widget.appMode),
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _orWidget() {
    return ShowUp(
      delay: 750,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        child: Text(translate('$_baseTranslate.or')),
      ),
    );
  }

  Widget _enterButton() {
    return ShowUp(
      delay: 750,
      child: FlatButton(
        onPressed: () => controller.signIn(context),
        color: Theme.of(context)
            .colorScheme
            .buttonBackgroundColor(appController.appMode),
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
            width: double.maxFinite * 0.8,
            height: 45,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                controller.loading
                    ? Container(
                        height: 25,
                        width: 25,
                        margin: EdgeInsets.only(right: 10),
                        child: CircularProgressIndicator(
                            strokeWidth: 1.4, backgroundColor: Colors.white),
                      )
                    : Container(),
                Text(
                  controller.loading
                      ? translate('common.loading')
                      : translate('$_baseTranslate.enter'),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )),
      ),
    );
  }

  Widget _divider() {
    return Divider(
      color: Colors.transparent,
    );
  }

  Widget _inputEmail() {
    return ShowUp(
      delay: 250,
      child: TextFormField(
        style: TextStyle(
          color: Theme.of(context).colorScheme.colorInput(widget.appMode),
        ),
        controller: controller.emailController,
        focusNode: _userFocus,
        textInputAction: TextInputAction.next,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onFieldSubmitted: (term) {
          _fieldFocusChange(context, _userFocus, _passwordFocus);
        },
        validator: (value) {
          return StringHelper.validateEmail(context, value);
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(BeautybookIcons.iconUser,
              color: _userFocus.hasFocus
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).colorScheme.iconInput(widget.appMode)),
          hintText: translate('$_baseTranslate.user'),
          contentPadding:
              EdgeInsets.only(bottom: 10, top: 10, left: 15, right: 15),
          enabledBorder: ThemeHelper.enableBorder(context, widget.appMode),
          focusedBorder: ThemeHelper.focusedBorder(context),
          errorBorder: ThemeHelper.errorBorder(context),
          focusedErrorBorder: ThemeHelper.errorBorder(context),
        ),
      ),
    );
  }

  Widget _passwordInput() {
    return ShowUp(
      delay: 500,
      child: TextFormField(
        style: TextStyle(
          color: Theme.of(context).colorScheme.colorInput(widget.appMode),
        ),
        controller: controller.passwordController,
        focusNode: _passwordFocus,
        textInputAction: TextInputAction.done,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText,
        onFieldSubmitted: (term) {
          controller.signIn(context);
        },
        validator: (value) {
          return StringHelper.validatePassword(context, value);
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(BeautybookIcons.iconKey,
              color: _passwordFocus.hasFocus
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).colorScheme.iconInput(widget.appMode)),
          suffixIcon: IconButton(
            icon: Icon(
                obscureText
                    ? BeautybookIcons.iconVisibility
                    : BeautybookIcons.iconVisibilityOff,
                color: _passwordFocus.hasFocus
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).colorScheme.iconInput(widget.appMode)),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
          hintText: translate('$_baseTranslate.password'),
          contentPadding:
              EdgeInsets.only(bottom: 10, top: 10, left: 15, right: 15),
          enabledBorder: ThemeHelper.enableBorder(context, widget.appMode),
          focusedBorder: ThemeHelper.focusedBorder(context),
          errorBorder: ThemeHelper.errorBorder(context),
          focusedErrorBorder: ThemeHelper.errorBorder(context),
        ),
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
