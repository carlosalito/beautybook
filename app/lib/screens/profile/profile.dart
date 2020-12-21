import 'package:beautybook/app_controller.dart';
import 'package:beautybook/core/constants/globals.dart';
import 'package:beautybook/core/constants/storage.dart';
import 'package:beautybook/core/constants/theme.dart';
import 'package:beautybook/core/extensions/theme.dart';
import 'package:beautybook/core/helpers/i18n/i18n_helper.dart';
import 'package:beautybook/core/helpers/string/string_helper.dart';
import 'package:beautybook/core/helpers/theme/theme_helper.dart';
import 'package:beautybook/core/icons/beautybook_icons.dart';
import 'package:beautybook/core/injectable/injectable.dart';
import 'package:beautybook/screens/profile/profile.controller.dart';
import 'package:beautybook/shared_widgets/circular_avatar/circular_avatar.dart';
import 'package:beautybook/shared_widgets/pick_image/pick_image.dart';
import 'package:beautybook/shared_widgets/show_animations/background_unfocus/background_unfocus.dart';
import 'package:beautybook/shared_widgets/translate_button/translate_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_cropper/image_cropper.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const _baseTranslate = 'profile';
  final controller = getIt<ProfileController>();
  final appController = getIt<AppController>();

  final FocusNode _nameFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    controller.nameController.text = appController.user.name;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: Constants.padding,
          vertical: Constants.padding,
        ),
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: BackgroundUnfocus(
            backgroundColor: Theme.of(context).backgroundColor,
            child: Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .cardColor(appController.appMode),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [ThemeHelper.boxCard(context)]),
              child: ListView(
                children: [
                  _profileImage(context),
                  _emailWidget(),
                  _form(context),
                  _appModeToggle(context),
                  _appLanguage(),
                  SizedBox(
                    height: Constants.doublePadding,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _appModeToggle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Constants.doublePadding),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            appController.toggleAppMode();
            setState(() {});
          },
          child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: Constants.doublePadding),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                        appController.appMode == AppMode.dark
                            ? BeautybookIcons.iconMoon
                            : BeautybookIcons.iconSun,
                        color: appController.appMode == AppMode.dark
                            ? Colors.white
                            : Theme.of(context).primaryColor),
                    SizedBox(width: Constants.padding),
                    Text(
                        I18nHelper.translate(
                            context,
                            appController.appMode == AppMode.dark
                                ? 'common.darkMode'
                                : 'common.lightMode'),
                        style: appController.appMode == AppMode.dark
                            ? TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)
                            : TextStyle(color: Theme.of(context).primaryColor))
                  ])),
        ),
      ),
    );
  }

  Widget _appLanguage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TranslateButton(
          language: Language.portuguese,
          size: 40,
          iconColor: appController.appMode == AppMode.dark
              ? Colors.white
              : Theme.of(context).primaryColor,
          callBack: () {
            setState(() {});
          },
        ),
        Padding(padding: EdgeInsets.only(right: Constants.doublePadding)),
        TranslateButton(
          language: Language.english,
          size: 40,
          iconColor: appController.appMode == AppMode.dark
              ? Colors.white
              : Theme.of(context).primaryColor,
          callBack: () {
            setState(() {});
          },
        )
      ],
    );
  }

  Widget _form(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _inputName(context),
              _actionButton(context),
            ],
          )),
    );
  }

  Widget _actionButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: FlatButton(
        onPressed: () => controller.updateUser(context),
        color: Theme.of(context)
            .colorScheme
            .buttonBackgroundColor(appController.appMode),
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
            width: double.maxFinite,
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
                      ? I18nHelper.translate(
                          context, '$_baseTranslate.loadingUpdate')
                      : I18nHelper.translate(context, '$_baseTranslate.update'),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )),
      ),
    );
  }

  Widget _inputName(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Theme.of(context).colorScheme.colorInput(appController.appMode),
      ),
      controller: controller.nameController,
      focusNode: _nameFocus,
      textInputAction: TextInputAction.done,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: (term) => controller.updateUser(context),
      validator: (value) {
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
        hintText: I18nHelper.translate(context, 'signUp.name'),
        contentPadding:
            EdgeInsets.only(bottom: 10, top: 10, left: 15, right: 15),
        enabledBorder: ThemeHelper.enableBorder(context, appController.appMode),
        focusedBorder: ThemeHelper.focusedBorder(context),
        errorBorder: ThemeHelper.errorBorder(context),
        focusedErrorBorder: ThemeHelper.errorBorder(context),
      ),
    );
  }

  Widget _emailWidget() {
    return Center(
      child: Padding(
          padding: EdgeInsets.only(
              top: Constants.padding, bottom: Constants.doublePadding),
          child: Text(
            appController.user?.email ?? '',
            style: TextStyle(fontSize: 16),
          )),
    );
  }

  Widget _profileImage(BuildContext context) {
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
              picture: appController.user?.picture ?? '',
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
                    color: Theme.of(context).accentColor),
                child: Icon(BeautybookIcons.iconCam,
                    color: Theme.of(context).backgroundColor)),
          )
        ],
      ),
    );
  }

  _changePicture(BuildContext context) {
    final _firebasePath =
        '${Storage.firebaseStorageUsers}/${appController.user.uid}.jpg';

    showModalBottomSheet(
        context: context,
        builder: (context) => PickImage(
              appMode: appController.appMode,
              firebasePath: _firebasePath,
              isRemovible: true,
              crop: true,
              sendImmediately: true,
              aspectRatio: CropAspectRatio(ratioX: .5, ratioY: .5),
              onImageSelected: (picture) async {
                if (picture == '') {
                  await controller.updateUserPicture(context, 'clear');
                } else {
                  await controller.updateUserPicture(context, 'update',
                      picture: picture);
                }

                Navigator.of(context).pop();
              },
            ));
  }
}
