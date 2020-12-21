import 'package:beautybook/app_controller.dart';
import 'package:beautybook/core/constants/theme.dart';
import 'package:beautybook/core/extensions/theme.dart';
import 'package:beautybook/core/injectable/injectable.dart';
import 'package:beautybook/screens/timeline/timeline.controller.dart';
import 'package:beautybook/screens/timeline/widgets/new_post_header.dart';
import 'package:beautybook/screens/timeline/widgets/timeline_body.dart';
import 'package:beautybook/shared_widgets/base_state/base_state.dart';
import 'package:beautybook/shared_widgets/show_animations/background_unfocus/background_unfocus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TimelineScreen extends StatefulWidget {
  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends BaseState<TimelineScreen> {
  final appController = getIt<AppController>();
  final controller = getIt<TimelineController>();

  final ScrollController controllerList = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    controllerList.addListener(_scrollListener);
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (controller.postList.length == 0) {
        await controller.list(context);
        if (appController.user != null) controller.manageNewPosts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SafeArea(
        child: BackgroundUnfocus(
          backgroundColor: Theme.of(context).backgroundColor,
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () => controller.refreshPosts(context),
            backgroundColor: Theme.of(context).backgroundColor,
            child: Stack(
              children: <Widget>[
                _loadingTimeline(),
                ListView(
                  controller: controllerList,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: <Widget>[
                    (appController.user != null &&
                            appController.user.uid != null &&
                            appController.user.uid != '')
                        ? NewPostHeader()
                        : Container(),
                    TimelineBody(),
                  ],
                ),
                _newPostsWidget(),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _loadingTimeline() {
    return controller.loading && !controller.refreshing
        ? Container(
            padding: EdgeInsets.only(bottom: Constants.padding),
            child: LinearProgressIndicator(),
          )
        : Container();
  }

  Widget _newPostsWidget() {
    return _showNewPostsHint()
        ? Align(
            alignment: Alignment.topCenter,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  _refreshIndicatorKey.currentState.show();
                  controllerList.animateTo(0,
                      duration: Duration(milliseconds: 350),
                      curve: Curves.ease);
                },
                child: Container(
                    // width: size.width * 0.55,
                    width: 150,
                    height: 35,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                        '${controller.newPosts.toString().padLeft(2, '0')} ' +
                            '${translate(controller.newPosts == 1 ? 'post.newPost' : 'post.newPosts')}',
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .textContrastColor))),
              ),
            ),
          )
        : Container();
  }

  bool _showNewPostsHint() {
    if (controller.newPosts != null && controller.newPosts > 0) {
      return true;
    }
    return false;
  }

  _scrollListener() {
    if (controllerList.offset >= controllerList.position.maxScrollExtent &&
        !controllerList.position.outOfRange) {
      controller.getMorePosts(context);
    }
  }
}
