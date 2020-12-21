// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boticario_news.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BoticarioNewsController on _BoticarioNewsControllerBase, Store {
  final _$newsListAtom = Atom(name: '_BoticarioNewsControllerBase.newsList');

  @override
  List<BoticarioNewsModel> get newsList {
    _$newsListAtom.reportRead();
    return super.newsList;
  }

  @override
  set newsList(List<BoticarioNewsModel> value) {
    _$newsListAtom.reportWrite(value, super.newsList, () {
      super.newsList = value;
    });
  }

  final _$loadingAtom = Atom(name: '_BoticarioNewsControllerBase.loading');

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

  final _$refreshingAtom =
      Atom(name: '_BoticarioNewsControllerBase.refreshing');

  @override
  bool get refreshing {
    _$refreshingAtom.reportRead();
    return super.refreshing;
  }

  @override
  set refreshing(bool value) {
    _$refreshingAtom.reportWrite(value, super.refreshing, () {
      super.refreshing = value;
    });
  }

  final _$refreshNewsAsyncAction =
      AsyncAction('_BoticarioNewsControllerBase.refreshNews');

  @override
  Future<void> refreshNews(BuildContext context) {
    return _$refreshNewsAsyncAction.run(() => super.refreshNews(context));
  }

  final _$listAsyncAction = AsyncAction('_BoticarioNewsControllerBase.list');

  @override
  Future<void> list(BuildContext context) {
    return _$listAsyncAction.run(() => super.list(context));
  }

  final _$_BoticarioNewsControllerBaseActionController =
      ActionController(name: '_BoticarioNewsControllerBase');

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_BoticarioNewsControllerBaseActionController
        .startAction(name: '_BoticarioNewsControllerBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_BoticarioNewsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRefreshing(bool value) {
    final _$actionInfo = _$_BoticarioNewsControllerBaseActionController
        .startAction(name: '_BoticarioNewsControllerBase.setRefreshing');
    try {
      return super.setRefreshing(value);
    } finally {
      _$_BoticarioNewsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
newsList: ${newsList},
loading: ${loading},
refreshing: ${refreshing}
    ''';
  }
}
