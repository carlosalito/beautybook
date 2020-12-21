// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TimelineController on _TimelineControllerBase, Store {
  final _$postListAtom = Atom(name: '_TimelineControllerBase.postList');

  @override
  List<PostModel> get postList {
    _$postListAtom.reportRead();
    return super.postList;
  }

  @override
  set postList(List<PostModel> value) {
    _$postListAtom.reportWrite(value, super.postList, () {
      super.postList = value;
    });
  }

  final _$pageInfoAtom = Atom(name: '_TimelineControllerBase.pageInfo');

  @override
  PageInfoModel get pageInfo {
    _$pageInfoAtom.reportRead();
    return super.pageInfo;
  }

  @override
  set pageInfo(PageInfoModel value) {
    _$pageInfoAtom.reportWrite(value, super.pageInfo, () {
      super.pageInfo = value;
    });
  }

  final _$pageAtom = Atom(name: '_TimelineControllerBase.page');

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  final _$newPostsAtom = Atom(name: '_TimelineControllerBase.newPosts');

  @override
  int get newPosts {
    _$newPostsAtom.reportRead();
    return super.newPosts;
  }

  @override
  set newPosts(int value) {
    _$newPostsAtom.reportWrite(value, super.newPosts, () {
      super.newPosts = value;
    });
  }

  final _$indexPictureShowAtom =
      Atom(name: '_TimelineControllerBase.indexPictureShow');

  @override
  int get indexPictureShow {
    _$indexPictureShowAtom.reportRead();
    return super.indexPictureShow;
  }

  @override
  set indexPictureShow(int value) {
    _$indexPictureShowAtom.reportWrite(value, super.indexPictureShow, () {
      super.indexPictureShow = value;
    });
  }

  final _$loadingAtom = Atom(name: '_TimelineControllerBase.loading');

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

  final _$refreshingAtom = Atom(name: '_TimelineControllerBase.refreshing');

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

  final _$deletingAtom = Atom(name: '_TimelineControllerBase.deleting');

  @override
  bool get deleting {
    _$deletingAtom.reportRead();
    return super.deleting;
  }

  @override
  set deleting(bool value) {
    _$deletingAtom.reportWrite(value, super.deleting, () {
      super.deleting = value;
    });
  }

  final _$bottomSpinAtom = Atom(name: '_TimelineControllerBase.bottomSpin');

  @override
  bool get bottomSpin {
    _$bottomSpinAtom.reportRead();
    return super.bottomSpin;
  }

  @override
  set bottomSpin(bool value) {
    _$bottomSpinAtom.reportWrite(value, super.bottomSpin, () {
      super.bottomSpin = value;
    });
  }

  final _$formKeyAtom = Atom(name: '_TimelineControllerBase.formKey');

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

  final _$titleControllerAtom =
      Atom(name: '_TimelineControllerBase.titleController');

  @override
  TextEditingController get titleController {
    _$titleControllerAtom.reportRead();
    return super.titleController;
  }

  @override
  set titleController(TextEditingController value) {
    _$titleControllerAtom.reportWrite(value, super.titleController, () {
      super.titleController = value;
    });
  }

  final _$postControllerAtom =
      Atom(name: '_TimelineControllerBase.postController');

  @override
  TextEditingController get postController {
    _$postControllerAtom.reportRead();
    return super.postController;
  }

  @override
  set postController(TextEditingController value) {
    _$postControllerAtom.reportWrite(value, super.postController, () {
      super.postController = value;
    });
  }

  final _$picturesAtom = Atom(name: '_TimelineControllerBase.pictures');

  @override
  List<String> get pictures {
    _$picturesAtom.reportRead();
    return super.pictures;
  }

  @override
  set pictures(List<String> value) {
    _$picturesAtom.reportWrite(value, super.pictures, () {
      super.pictures = value;
    });
  }

  final _$uploadProgressAtom =
      Atom(name: '_TimelineControllerBase.uploadProgress');

  @override
  double get uploadProgress {
    _$uploadProgressAtom.reportRead();
    return super.uploadProgress;
  }

  @override
  set uploadProgress(double value) {
    _$uploadProgressAtom.reportWrite(value, super.uploadProgress, () {
      super.uploadProgress = value;
    });
  }

  final _$listAsyncAction = AsyncAction('_TimelineControllerBase.list');

  @override
  Future<void> list(BuildContext context, {dynamic reset = false}) {
    return _$listAsyncAction.run(() => super.list(context, reset: reset));
  }

  final _$refreshPostsAsyncAction =
      AsyncAction('_TimelineControllerBase.refreshPosts');

  @override
  Future<void> refreshPosts(BuildContext context, {dynamic setRefresh = true}) {
    return _$refreshPostsAsyncAction
        .run(() => super.refreshPosts(context, setRefresh: setRefresh));
  }

  final _$getMorePostsAsyncAction =
      AsyncAction('_TimelineControllerBase.getMorePosts');

  @override
  Future<void> getMorePosts(BuildContext context) {
    return _$getMorePostsAsyncAction.run(() => super.getMorePosts(context));
  }

  final _$savePostAsyncAction = AsyncAction('_TimelineControllerBase.savePost');

  @override
  Future savePost(BuildContext context, String uid) {
    return _$savePostAsyncAction.run(() => super.savePost(context, uid));
  }

  final _$updateGaleryAsyncAction =
      AsyncAction('_TimelineControllerBase.updateGalery');

  @override
  Future<void> updateGalery(BuildContext context, String postUid) {
    return _$updateGaleryAsyncAction
        .run(() => super.updateGalery(context, postUid));
  }

  final _$deleteFileAsyncAction =
      AsyncAction('_TimelineControllerBase.deleteFile');

  @override
  Future<void> deleteFile(BuildContext context, int index, String postUid) {
    return _$deleteFileAsyncAction
        .run(() => super.deleteFile(context, index, postUid));
  }

  final _$editPostAsyncAction = AsyncAction('_TimelineControllerBase.editPost');

  @override
  Future<void> editPost(PostModel post) {
    return _$editPostAsyncAction.run(() => super.editPost(post));
  }

  final _$deletePostAsyncAction =
      AsyncAction('_TimelineControllerBase.deletePost');

  @override
  Future<void> deletePost(BuildContext context, PostModel post) {
    return _$deletePostAsyncAction.run(() => super.deletePost(context, post));
  }

  final _$_TimelineControllerBaseActionController =
      ActionController(name: '_TimelineControllerBase');

  @override
  dynamic dispose() {
    final _$actionInfo = _$_TimelineControllerBaseActionController.startAction(
        name: '_TimelineControllerBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$_TimelineControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_TimelineControllerBaseActionController.startAction(
        name: '_TimelineControllerBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_TimelineControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDeleteState(bool value) {
    final _$actionInfo = _$_TimelineControllerBaseActionController.startAction(
        name: '_TimelineControllerBase.setDeleteState');
    try {
      return super.setDeleteState(value);
    } finally {
      _$_TimelineControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRefreshing(bool value) {
    final _$actionInfo = _$_TimelineControllerBaseActionController.startAction(
        name: '_TimelineControllerBase.setRefreshing');
    try {
      return super.setRefreshing(value);
    } finally {
      _$_TimelineControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBottomSpin(bool value) {
    final _$actionInfo = _$_TimelineControllerBaseActionController.startAction(
        name: '_TimelineControllerBase.setBottomSpin');
    try {
      return super.setBottomSpin(value);
    } finally {
      _$_TimelineControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setProgress(double value) {
    final _$actionInfo = _$_TimelineControllerBaseActionController.startAction(
        name: '_TimelineControllerBase.setProgress');
    try {
      return super.setProgress(value);
    } finally {
      _$_TimelineControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPage(int value) {
    final _$actionInfo = _$_TimelineControllerBaseActionController.startAction(
        name: '_TimelineControllerBase.setPage');
    try {
      return super.setPage(value);
    } finally {
      _$_TimelineControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIndexPictureShow(int value) {
    final _$actionInfo = _$_TimelineControllerBaseActionController.startAction(
        name: '_TimelineControllerBase.setIndexPictureShow');
    try {
      return super.setIndexPictureShow(value);
    } finally {
      _$_TimelineControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addItemToGalery(String item) {
    final _$actionInfo = _$_TimelineControllerBaseActionController.startAction(
        name: '_TimelineControllerBase.addItemToGalery');
    try {
      return super.addItemToGalery(item);
    } finally {
      _$_TimelineControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic initGalery() {
    final _$actionInfo = _$_TimelineControllerBaseActionController.startAction(
        name: '_TimelineControllerBase.initGalery');
    try {
      return super.initGalery();
    } finally {
      _$_TimelineControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic formPost(PostModel post) {
    final _$actionInfo = _$_TimelineControllerBaseActionController.startAction(
        name: '_TimelineControllerBase.formPost');
    try {
      return super.formPost(post);
    } finally {
      _$_TimelineControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic postDetail(PostModel post) {
    final _$actionInfo = _$_TimelineControllerBaseActionController.startAction(
        name: '_TimelineControllerBase.postDetail');
    try {
      return super.postDetail(post);
    } finally {
      _$_TimelineControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNewPosts(int value) {
    final _$actionInfo = _$_TimelineControllerBaseActionController.startAction(
        name: '_TimelineControllerBase.setNewPosts');
    try {
      return super.setNewPosts(value);
    } finally {
      _$_TimelineControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void manageNewPosts() {
    final _$actionInfo = _$_TimelineControllerBaseActionController.startAction(
        name: '_TimelineControllerBase.manageNewPosts');
    try {
      return super.manageNewPosts();
    } finally {
      _$_TimelineControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
postList: ${postList},
pageInfo: ${pageInfo},
page: ${page},
newPosts: ${newPosts},
indexPictureShow: ${indexPictureShow},
loading: ${loading},
refreshing: ${refreshing},
deleting: ${deleting},
bottomSpin: ${bottomSpin},
formKey: ${formKey},
titleController: ${titleController},
postController: ${postController},
pictures: ${pictures},
uploadProgress: ${uploadProgress}
    ''';
  }
}
