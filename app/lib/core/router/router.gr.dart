// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';

import '../../screens/navigator/navigator.dart';
import '../../screens/sign/signin.dart';
import '../../screens/sign/signup.dart';
import '../../screens/splash/splash.dart';
import '../../screens/timeline/post_details_screen.dart';
import '../../screens/timeline/post_screen.dart';
import '../models/post/post_model.dart';

class Routes {
  static const String splashScreen = '/';
  static const String signInScreen = '/signIn';
  static const String signUpScreen = '/signUp';
  static const String navigatorScreen = '/home';
  static const String postScreen = '/post';
  static const String postDetailsScreen = '/post-etail';
  static const all = <String>{
    splashScreen,
    signInScreen,
    signUpScreen,
    navigatorScreen,
    postScreen,
    postDetailsScreen,
  };
}

class AppRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashScreen, page: SplashScreen),
    RouteDef(Routes.signInScreen, page: SignInScreen),
    RouteDef(Routes.signUpScreen, page: SignUpScreen),
    RouteDef(Routes.navigatorScreen, page: NavigatorScreen),
    RouteDef(Routes.postScreen, page: PostScreen),
    RouteDef(Routes.postDetailsScreen, page: PostDetailsScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashScreen: (data) {
      return buildAdaptivePageRoute<SplashScreen>(
        builder: (context) => SplashScreen(),
        settings: data,
      );
    },
    SignInScreen: (data) {
      return buildAdaptivePageRoute<SignInScreen>(
        builder: (context) => SignInScreen(),
        settings: data,
      );
    },
    SignUpScreen: (data) {
      return buildAdaptivePageRoute<SignUpScreen>(
        builder: (context) => SignUpScreen(),
        settings: data,
      );
    },
    NavigatorScreen: (data) {
      return buildAdaptivePageRoute<NavigatorScreen>(
        builder: (context) => NavigatorScreen(),
        settings: data,
      );
    },
    PostScreen: (data) {
      final args = data.getArgs<PostScreenArguments>(
        orElse: () => PostScreenArguments(),
      );
      return buildAdaptivePageRoute<PostScreen>(
        builder: (context) => PostScreen(post: args.post),
        settings: data,
      );
    },
    PostDetailsScreen: (data) {
      final args = data.getArgs<PostDetailsScreenArguments>(
        orElse: () => PostDetailsScreenArguments(),
      );
      return buildAdaptivePageRoute<PostDetailsScreen>(
        builder: (context) => PostDetailsScreen(post: args.post),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// PostScreen arguments holder class
class PostScreenArguments {
  final PostModel post;
  PostScreenArguments({this.post});
}

/// PostDetailsScreen arguments holder class
class PostDetailsScreenArguments {
  final PostModel post;
  PostDetailsScreenArguments({this.post});
}
