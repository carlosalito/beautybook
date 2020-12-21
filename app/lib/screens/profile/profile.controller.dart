import 'package:beautybook/app_controller.dart';
import 'package:beautybook/core/helpers/i18n/i18n_helper.dart';
import 'package:beautybook/core/models/user/user_model.dart';
import 'package:beautybook/core/repositories/user_repository.dart';
import 'package:beautybook/core/services/notification/notifications.service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'profile.controller.g.dart';

@injectable
class ProfileController = _ProfileControllerBase with _$ProfileController;

abstract class _ProfileControllerBase with Store {
  UserRepository repository;
  AppController appController;

  _ProfileControllerBase({this.repository, this.appController});

  @observable
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @observable
  TextEditingController nameController = TextEditingController();

  @observable
  bool loading = false;

  @action
  setLoading(bool value) {
    loading = value;
  }

  @action
  void toggleAppMode() {
    appController.toggleAppMode();
  }

  @action
  Future<void> updateUserPicture(BuildContext context, String action,
      {String picture}) async {
    try {
      await repository.updateUserPicture(action);
      appController.setUserPicture(picture);
    } catch (e) {
      Notifications.error(
        context: context,
        message: I18nHelper.translate(context, 'profile.errorUpdatePicture'),
      );
    }
  }

  @action
  Future<void> updateUser(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (nameController.text.isEmpty) {
      Notifications.alert(
        context: context,
        message: I18nHelper.translate(context, 'validators.emptyName'),
      );
    } else {
      try {
        setLoading(true);
        final _json = appController.user.toJson();
        _json['name'] = nameController.text;
        final _user = UserModel.fromJson(_json);
        await repository.updateUser(_user);
        setLoading(false);
      } catch (e) {
        setLoading(false);

        Notifications.error(
          context: context,
          message: I18nHelper.translate(context, 'profile.errorUpdate'),
        );
      }
    }
  }
}
