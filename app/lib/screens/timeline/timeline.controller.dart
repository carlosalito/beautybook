import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:beautybook/app_controller.dart';
import 'package:beautybook/core/constants/collections.dart';
import 'package:beautybook/core/constants/storage.dart';
import 'package:beautybook/core/helpers/hive/hive_helper.dart';
import 'package:beautybook/core/helpers/i18n/i18n_helper.dart';
import 'package:beautybook/core/models/post/post_model.dart';
import 'package:beautybook/core/models/response/page_info_model.dart';
import 'package:beautybook/core/repositories/timeline_repository.dart';
import 'package:beautybook/core/router/router.gr.dart';
import 'package:beautybook/core/services/notification/notifications.service.dart';
import 'package:beautybook/core/services/utils/utils.services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'timeline.controller.g.dart';

@singleton
class TimelineController = _TimelineControllerBase with _$TimelineController;

abstract class _TimelineControllerBase with Store {
  AppController appController;
  TimelineRepository repository;

  _TimelineControllerBase({this.appController, this.repository});

  @observable
  List<PostModel> postList = [];

  @observable
  PageInfoModel pageInfo = PageInfoModel(totalPages: 0, totalRows: 0);

  @observable
  int page = 0;

  @observable
  int newPosts = 0;

  @observable
  int indexPictureShow = 0;

  @observable
  bool loading = false;

  @observable
  bool refreshing = false;

  @observable
  bool deleting = false;

  @observable
  bool bottomSpin = false;

  @observable
  var formKey = GlobalKey<FormState>();

  @observable
  TextEditingController titleController = TextEditingController();

  @observable
  TextEditingController postController = TextEditingController();

  @observable
  List<String> pictures;

  @observable
  double uploadProgress = 0.0;

  @action
  dispose() {
    titleController.dispose();
    postController.dispose();
  }

  @action
  void setLoading(bool value) {
    loading = value;
  }

  @action
  void setDeleteState(bool value) {
    deleting = value;
  }

  @action
  void setRefreshing(bool value) {
    refreshing = value;
  }

  @action
  void setBottomSpin(bool value) {
    bottomSpin = value;
  }

  @action
  void setProgress(double value) {
    uploadProgress = value;
  }

  @action
  void setPage(int value) {
    page = value;
  }

  @action
  void setIndexPictureShow(int value) {
    indexPictureShow = value;
  }

  Future<List<String>> _resolvePictures(String postId) async {
    final List<String> _pictures = [];

    if (pictures.length > 0) {
      setProgress(null);

      for (var i = 0; i < pictures.length; i++) {
        final String pic = pictures[i];
        if (pic.startsWith('https://')) {
          _pictures.add(pic);
        } else {
          final picUid = UtilsServices.uId();
          final url = '${Storage.firebaseStorageTimeline}/$postId/$picUid.jpg';
          final Uri uri = Uri.file(pic);
          final File file = File.fromUri(uri);

          final _task = UtilsServices.uploadFile(url, file);
          await _task.whenComplete(() {
            final _progress = (1 / pictures.length) * (i + 1);
            print('progress ${_progress.toString()}');
            setProgress(_progress);
          });
          _pictures.add(await UtilsServices.getFireUrl(url));
        }
      }
    }
    return _pictures;
  }

  @action
  addItemToGalery(String item) {
    pictures = [...pictures, item];
  }

  @action
  initGalery() {
    pictures = [];
  }

  @action
  formPost(PostModel post) {
    final _post =
        post != null ? post : PostModel(title: '', body: '', uid: null);
    if (post == null) initGalery();
    ExtendedNavigator.root
        .push(Routes.postScreen, arguments: PostScreenArguments(post: _post));
  }

  @action
  postDetail(PostModel post) {
    ExtendedNavigator.root.push(Routes.postDetailsScreen,
        arguments: PostDetailsScreenArguments(post: post));
  }

  @action
  Future<void> list(BuildContext context, {reset = false}) async {
    try {
      setLoading(true);
      final _result = await repository.list(page);
      pageInfo = _result['pageInfo'];

      if (reset) postList = [];
      postList = [...postList, ..._result['data']];
      setLoading(false);
    } catch (e) {
      Notifications.error(
          context: context,
          message: I18nHelper.translate(context, 'timeline.listError'));
      setLoading(false);
      throw (e);
    }
  }

  @action
  Future<void> refreshPosts(BuildContext context, {setRefresh = true}) async {
    setRefreshing(setRefresh);
    page = 0;
    pageInfo = PageInfoModel(totalPages: 0, totalRows: 0);
    await list(context, reset: true);
    _updateLastRead();
    setRefreshing(false);
  }

  void _updateLastRead() {
    HiveHelper.saveValueInBox(Storage.lastRead, DateTime.now());
    setNewPosts(0);
  }

  @action
  Future<void> getMorePosts(BuildContext context) async {
    if (page < pageInfo.totalPages - 1) {
      setPage(page + 1);
      setBottomSpin(true);
      await list(context);
      setBottomSpin(false);
    }
  }

  @action
  savePost(
    BuildContext context,
    String uid,
  ) async {
    try {
      FocusScope.of(context).requestFocus(FocusNode());
      FocusScope.of(context).unfocus();

      if (formKey.currentState.validate() && !loading) {
        setLoading(true);
        final _uid = uid != null ? uid : UtilsServices.uId();
        final List<String> _pictures = await _resolvePictures(_uid);
        setProgress(null);

        PostModel _post = PostModel(
          uid: _uid,
          body: postController.text,
          title: titleController.text,
          pictures: _pictures,
        );

        await repository.create(_post);
        refreshPosts(context, setRefresh: false);
        ExtendedNavigator.root.pop();
      }
    } catch (e) {
      Notifications.error(
          context: context,
          message: I18nHelper.translate(context, 'post.error'));
      setLoading(false);
      throw (e);
    }
  }

  _removeItemFromGalery(int index) {
    pictures.removeAt(index);
  }

  _deleteTempFile(int index) {
    final String image = pictures[index];

    final Uri uri = Uri.file(image);
    final File file = File.fromUri(uri);
    file.deleteSync();

    _removeItemFromGalery(index);
  }

  @action
  Future<void> updateGalery(BuildContext context, String postUid) async {
    try {
      await repository.updateGalery(pictures: pictures, postId: postUid);
    } catch (e) {
      Notifications.error(
          context: context,
          message: I18nHelper.translate(context, 'post.errorGalery'));
    }
  }

  @action
  Future<void> deleteFile(
      BuildContext context, int index, String postUid) async {
    final String image = pictures[index];
    if (image.startsWith('https://')) {
      final bool result = await UtilsServices.deleteFirebaseFile(image);
      if (result) {
        _removeItemFromGalery(index);
        await updateGalery(context, postUid);
      }
    } else {
      _deleteTempFile(index);
    }
  }

  @action
  void setNewPosts(int value) {
    newPosts = value;
  }

  @action
  void manageNewPosts() {
    final _date = HiveHelper.getValueInBox(Storage.lastRead) ?? DateTime.now();

    FirebaseFirestore.instance
        .collection(Collections.timeline)
        .where('createdAt', isGreaterThanOrEqualTo: _date)
        .snapshots()
        .listen((data) {
      int _newItens = 0;
      for (var doc in data.docs) {
        if (doc.data()['userUid'] != appController.user.uid) {
          _newItens++;
        }
      }
      setNewPosts(_newItens);
    });
  }

  @action
  Future<void> editPost(PostModel post) async {
    pictures = post.pictures;
    formPost(post);
  }

  @action
  Future<void> deletePost(BuildContext context, PostModel post) async {
    try {
      setDeleteState(true);
      await repository.delete(post.uid);
      setDeleteState(false);
      refreshPosts(context, setRefresh: false);
    } catch (e) {
      setDeleteState(false);
      Notifications.error(
        context: context,
        message: I18nHelper.translate(context, 'post.delete.error'),
      );
    }
  }
}
