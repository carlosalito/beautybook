import 'package:beautybook/app_controller.dart';
import 'package:beautybook/core/constants/theme.dart';
import 'package:beautybook/core/extensions/theme.dart';
import 'package:beautybook/core/helpers/string/string_helper.dart';
import 'package:beautybook/core/helpers/theme/theme_helper.dart';
import 'package:beautybook/core/icons/beautybook_icons.dart';
import 'package:beautybook/core/injectable/injectable.dart';
import 'package:beautybook/core/models/user/app_mode_enum.dart';
import 'package:beautybook/screens/sign/signup.controller.dart';
import 'package:beautybook/shared_widgets/base_state/base_state.dart';
import 'package:beautybook/shared_widgets/circular_avatar/circular_avatar.dart';
import 'package:beautybook/shared_widgets/pick_image/pick_image.dart';
import 'package:beautybook/shared_widgets/show_animations/background_unfocus/background_unfocus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_cropper/image_cropper.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen();
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends BaseState<SignUpScreen> {
  final controller = getIt<SignUpController>();
  final appController = getIt<AppController>();
  static const _baseTranslate = 'signUp';

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = true;
  }

  @override
  Widget build(BuildContext context) {
    final _appMode = appController.appMode;
    return Scaffold(
      appBar: AppBar(
        brightness:
            _appMode == AppMode.dark ? Brightness.dark : Brightness.light,
        iconTheme: Theme.of(context).iconTheme,
        actionsIconTheme: Theme.of(context).iconTheme,
        title: Text(
          translate('$_baseTranslate.create'),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Theme.of(context).colorScheme.cardColor(_appMode),
      ),
      body: Observer(builder: (context) {
        return Container(
          color: Theme.of(context).backgroundColor,
          child: SafeArea(
            child: BackgroundUnfocus(
              backgroundColor: Theme.of(context).backgroundColor,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(Constants.padding),
                  padding: EdgeInsets.all(Constants.padding),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.cardColor(_appMode),
                      borderRadius: BorderRadius.all(
                        Radius.circular(Constants.borderRadius),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(.5),
                            blurRadius: 15.0,
                            spreadRadius: -5.0,
                            offset: Offset(0.0, 5.0))
                      ]),
                  child: Column(
                    children: <Widget>[
                      _imagePicker(),
                      _divider(),
                      _form(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _form() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _emailInput(),
              _nameInput(),
              _passwordInput(),
              _actionButton(),
            ],
          )),
    );
  }

  Widget _actionButton() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: FlatButton(
        key: new Key('create'),
        onPressed: () => controller.createUser(context),
        color: Theme.of(context).primaryColor,
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
                      ? translate('$_baseTranslate.loadingCreate')
                      : translate('$_baseTranslate.createButton'),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )),
      ),
    );
  }

  Widget _passwordInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        style: TextStyle(
          color:
              Theme.of(context).colorScheme.colorInput(appController.appMode),
        ),
        key: new Key('password'),
        controller: controller.passwordController,
        focusNode: _passwordFocus,
        textInputAction: TextInputAction.done,
        obscureText: obscureText,
        onTap: () => _requestFocus('password'),
        onFieldSubmitted: (term) {
          controller.createUser(context);
        },
        validator: (value) {
          FocusScope.of(context).requestFocus(_passwordFocus);
          return StringHelper.validatePassword(context, value);
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(BeautybookIcons.iconKey,
              color: _passwordFocus.hasFocus
                  ? Theme.of(context).primaryColor
                  : Theme.of(context)
                      .colorScheme
                      .iconInput(appController.appMode)),
          suffixIcon: IconButton(
            icon: Icon(
                obscureText
                    ? BeautybookIcons.iconVisibility
                    : BeautybookIcons.iconVisibilityOff,
                color: _passwordFocus.hasFocus
                    ? Theme.of(context).primaryColor
                    : Theme.of(context)
                        .colorScheme
                        .iconInput(appController.appMode)),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
          hintText: translate('signin.password'),
          contentPadding:
              EdgeInsets.only(bottom: 10, top: 10, left: 15, right: 15),
          enabledBorder:
              ThemeHelper.enableBorder(context, appController.appMode),
          focusedBorder: ThemeHelper.focusedBorder(context),
          errorBorder: ThemeHelper.errorBorder(context),
          focusedErrorBorder: ThemeHelper.errorBorder(context),
        ),
      ),
    );
  }

  Widget _nameInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        style: TextStyle(
          color:
              Theme.of(context).colorScheme.colorInput(appController.appMode),
        ),
        key: new Key('name'),
        controller: controller.nameController,
        focusNode: _nameFocus,
        textInputAction: TextInputAction.next,
        onTap: () {
          FocusScope.of(context).requestFocus(_nameFocus);
        },
        onFieldSubmitted: (term) {
          _fieldFocusChange(context, _nameFocus, _passwordFocus);
        },
        validator: (value) {
          FocusScope.of(context).requestFocus(_nameFocus);
          return StringHelper.validateName(context, value);
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(BeautybookIcons.iconUser,
              color: _nameFocus.hasFocus
                  ? Theme.of(context).primaryColor
                  : Theme.of(context)
                      .colorScheme
                      .iconInput(appController.appMode)),
          hintText: translate('$_baseTranslate.name'),
          contentPadding:
              EdgeInsets.only(bottom: 10, top: 10, left: 15, right: 15),
          enabledBorder:
              ThemeHelper.enableBorder(context, appController.appMode),
          focusedBorder: ThemeHelper.focusedBorder(context),
          errorBorder: ThemeHelper.errorBorder(context),
          focusedErrorBorder: ThemeHelper.errorBorder(context),
        ),
      ),
    );
  }

  Widget _emailInput() {
    return Padding(
      padding: EdgeInsets.only(bottom: Constants.padding),
      child: TextFormField(
        style: TextStyle(
          color:
              Theme.of(context).colorScheme.colorInput(appController.appMode),
        ),
        key: new Key('email'),
        controller: controller.emailController,
        focusNode: _emailFocus,
        textInputAction: TextInputAction.next,
        onTap: () => _requestFocus('email'),
        onFieldSubmitted: (term) {
          _fieldFocusChange(context, _emailFocus, _nameFocus);
        },
        validator: (value) {
          FocusScope.of(context).requestFocus(_emailFocus);
          return StringHelper.validateEmail(context, value);
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(BeautybookIcons.iconUser,
              color: _emailFocus.hasFocus
                  ? Theme.of(context).primaryColor
                  : Theme.of(context)
                      .colorScheme
                      .iconInput(appController.appMode)),
          hintText: translate('signin.user'),
          contentPadding:
              EdgeInsets.only(bottom: 10, top: 10, left: 15, right: 15),
          enabledBorder:
              ThemeHelper.enableBorder(context, appController.appMode),
          focusedBorder: ThemeHelper.focusedBorder(context),
          errorBorder: ThemeHelper.errorBorder(context),
          focusedErrorBorder: ThemeHelper.errorBorder(context),
        ),
      ),
    );
  }

  Widget _divider() {
    return SizedBox(
      height: Constants.padding,
    );
  }

  Widget _imagePicker() {
    return GestureDetector(
      onTap: () => _changePicture(context),
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 25),
            alignment: Alignment.center,
            child: CircularAvatar(
              noCache: true,
              size: 120,
              picture: controller.picture,
            ),
          ),
          Center(
            child: Container(
              alignment: Alignment.center,
              height: 35,
              width: 35,
              margin: EdgeInsets.only(left: 90, top: 20),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor),
              child: Icon(BeautybookIcons.iconCam,
                  color: Theme.of(context).backgroundColor),
            ),
          )
        ],
      ),
    );
  }

  void _requestFocus(String type) {
    setState(() {
      type == 'name'
          ? FocusScope.of(context).requestFocus(_nameFocus)
          : type == 'email'
              ? FocusScope.of(context).requestFocus(_emailFocus)
              : FocusScope.of(context).requestFocus(_passwordFocus);
    });
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  _changePicture(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return PickImage(
              firebasePath: null,
              isRemovible: true,
              crop: true,
              sendImmediately: false,
              aspectRatio: CropAspectRatio(ratioX: .5, ratioY: .5),
              onImageSelected: (pic) {
                controller.setPicture(pic);

                _requestFocus('email');
                Navigator.of(context).pop();
              },
            );
          });
        });
  }
}
