import 'package:beautybook/app_controller.dart';
import 'package:beautybook/core/constants/theme.dart';
import 'package:beautybook/core/extensions/theme.dart';
import 'package:beautybook/core/helpers/string/string_helper.dart';
import 'package:beautybook/core/helpers/theme/theme_helper.dart';
import 'package:beautybook/core/icons/beautybook_icons.dart';
import 'package:beautybook/core/injectable/injectable.dart';
import 'package:beautybook/core/models/post/post_model.dart';
import 'package:beautybook/core/models/user/app_mode_enum.dart';
import 'package:beautybook/screens/timeline/timeline.controller.dart';
import 'package:beautybook/screens/timeline/widgets/picture_post_tile.dart';
import 'package:beautybook/shared_widgets/base_state/base_state.dart';
import 'package:beautybook/shared_widgets/pick_image/pick_image.dart';
import 'package:beautybook/shared_widgets/show_animations/background_unfocus/background_unfocus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PostScreen extends StatefulWidget {
  final PostModel post;
  PostScreen({this.post});
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends BaseState<PostScreen> {
  static const String _baseTranslate = 'post';
  final appController = getIt<AppController>();
  final controller = getIt<TimelineController>();

  final FocusNode _postTitleFocus = FocusNode();
  final FocusNode _postBodyFocus = FocusNode();
  bool haveImages;

  @override
  void initState() {
    super.initState();
    haveImages = false;

    controller.titleController.text = widget.post.title;
    controller.postController.text = widget.post.body;
  }

  @override
  Widget build(BuildContext context) {
    final appMode = appController.appMode;

    return Scaffold(
      appBar: AppBar(
        brightness:
            appMode == AppMode.dark ? Brightness.dark : Brightness.light,
        iconTheme: Theme.of(context).iconTheme,
        actionsIconTheme: Theme.of(context).iconTheme,
        title: Text(
          translate('$_baseTranslate.title'),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Theme.of(context).colorScheme.cardColor(appMode),
        actions: <Widget>[
          _actionButton(),
        ],
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: BackgroundUnfocus(
            backgroundColor: Theme.of(context).backgroundColor,
            child: SingleChildScrollView(
              child: Observer(builder: (context) {
                return Column(
                  children: <Widget>[
                    _loadingWidget(),
                    _form(),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _form() {
    return Container(
      margin: EdgeInsets.all(Constants.padding),
      padding: EdgeInsets.all(Constants.padding),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.cardColor(appController.appMode),
          borderRadius:
              BorderRadius.all(Radius.circular(Constants.borderRadius)),
          boxShadow: [ThemeHelper.boxCard(context)]),
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _titleInput(),
            SizedBox(height: Constants.padding),
            _bodyInput(),
            SizedBox(height: Constants.padding),
            _galery(),
          ],
        ),
      ),
    );
  }

  Widget _galeryButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          _selectImage(context);
        },
        child: Container(
            height: 95,
            width: 95,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: Theme.of(context).primaryColor)),
            child: Icon(BeautybookIcons.iconCam,
                size: 35, color: Theme.of(context).primaryColor)),
      ),
    );
  }

  Widget _galery() {
    final Size size = MediaQuery.of(context).size;

    return Container(
      child: Row(
        children: <Widget>[
          _galeryButton(),
          controller.pictures.length > 0
              ? Container(
                  height: 95,
                  width: size.width - 135,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemExtent: 100,
                      itemCount: controller.pictures.length,
                      itemBuilder: (context, index) {
                        return PicturePostTile(
                          url: controller.pictures[index],
                          index: index,
                          postUid: widget.post.uid,
                        );
                      }))
              : Container()
        ],
      ),
    );
  }

  Widget _titleInput() {
    return TextFormField(
      style: TextStyle(
        color: Theme.of(context).colorScheme.colorInput(appController.appMode),
      ),
      controller: controller.titleController,
      focusNode: _postTitleFocus,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _postTitleFocus, _postBodyFocus);
      },
      onTap: () => _requestFocus('title'),
      validator: (value) {
        _requestFocus('title');
        return StringHelper.validateTitle(context, value);
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: translate('$_baseTranslate.form.title'),
        contentPadding:
            EdgeInsets.only(bottom: 10, top: 10, left: 15, right: 15),
        enabledBorder: ThemeHelper.enableBorder(context, appController.appMode),
        focusedBorder: ThemeHelper.focusedBorder(context),
        errorBorder: ThemeHelper.errorBorder(context),
        focusedErrorBorder: ThemeHelper.errorBorder(context),
      ),
    );
  }

  Widget _bodyInput() {
    final Size size = MediaQuery.of(context).size;
    final double hAppBar = AppBar().preferredSize.height;
    final int hImages = 120;
    final double hOthers = 130 + hAppBar;

    return TextFormField(
      style: TextStyle(
        color: Theme.of(context).colorScheme.colorInput(appController.appMode),
      ),
      controller: controller.postController,
      focusNode: _postBodyFocus,
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      maxLines: ((size.height - hOthers - hImages) / 20).floor(),
      onTap: () {
        FocusScope.of(context).requestFocus(_postBodyFocus);
      },
      validator: (value) {
        FocusScope.of(context).requestFocus(_postBodyFocus);
        return StringHelper.validatePost(context, value);
      },
      decoration: InputDecoration(
        hintText: translate('$_baseTranslate.form.body'),
        contentPadding:
            EdgeInsets.only(bottom: 10, top: 10, left: 15, right: 15),
        enabledBorder: ThemeHelper.enableBorder(context, appController.appMode),
        focusedBorder: ThemeHelper.focusedBorder(context),
        errorBorder: ThemeHelper.errorBorder(context),
        focusedErrorBorder: ThemeHelper.errorBorder(context),
      ),
    );
  }

  Widget _loadingWidget() {
    return controller.loading
        ? Container(
            child: LinearProgressIndicator(value: controller.uploadProgress),
          )
        : Container();
  }

  _actionButton() {
    return Container(
      padding: EdgeInsets.only(right: 5),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => controller.savePost(context, widget.post.uid),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Constants.doublePadding),
              child: Icon(
                BeautybookIcons.iconSend,
                size: 20,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          )),
    );
  }

  _selectImage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => PickImage(
              appMode: appController.appMode,
              firebasePath: null,
              isRemovible: false,
              crop: false,
              sendImmediately: false,
              aspectRatio: null,
              onImageSelected: (picture) {
                if (picture != null) {
                  FocusScope.of(context).unfocus();
                  controller.addItemToGalery(picture);
                }
                Navigator.of(context).pop();
              },
            ));
  }

  void _requestFocus(String type) {
    setState(() {
      type == 'title'
          ? FocusScope.of(context).requestFocus(_postTitleFocus)
          : FocusScope.of(context).requestFocus(_postBodyFocus);
    });
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
