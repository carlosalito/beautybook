// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileController on _ProfileControllerBase, Store {
  final _$formKeyAtom = Atom(name: '_ProfileControllerBase.formKey');

  @override
  GlobalKey<FormState> get formKey {
    _$formKeyAtom.reportRead();
    return super.formKey;
  }

  @override
  set formKey(GlobalKey<FormState> value) {
    _$formKeyAtom.reportWrite(value, super.formKey, () {
      super.formKey = value;
    });
  }

  final _$nameControllerAtom =
      Atom(name: '_ProfileControllerBase.nameController');

  @override
  TextEditingController get nameController {
    _$nameControllerAtom.reportRead();
    return super.nameController;
  }

  @override
  set nameController(TextEditingController value) {
    _$nameControllerAtom.reportWrite(value, super.nameController, () {
      super.nameController = value;
    });
  }

  final _$loadingAtom = Atom(name: '_ProfileControllerBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$updateUserPictureAsyncAction =
      AsyncAction('_ProfileControllerBase.updateUserPicture');

  @override
  Future<void> updateUserPicture(BuildContext context, String action,
      {String picture}) {
    return _$updateUserPictureAsyncAction
        .run(() => super.updateUserPicture(context, action, picture: picture));
  }

  final _$updateUserAsyncAction =
      AsyncAction('_ProfileControllerBase.updateUser');

  @override
  Future<void> updateUser(BuildContext context) {
    return _$updateUserAsyncAction.run(() => super.updateUser(context));
  }

  final _$_ProfileControllerBaseActionController =
      ActionController(name: '_ProfileControllerBase');

  @override
  dynamic setLoading(bool value) {
    final _$actionInfo = _$_ProfileControllerBaseActionController.startAction(
        name: '_ProfileControllerBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_ProfileControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleAppMode() {
    final _$actionInfo = _$_ProfileControllerBaseActionController.startAction(
        name: '_ProfileControllerBase.toggleAppMode');
    try {
      return super.toggleAppMode();
    } finally {
      _$_ProfileControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
formKey: ${formKey},
nameController: ${nameController},
loading: ${loading}
    ''';
  }
}
