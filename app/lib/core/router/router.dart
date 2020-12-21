import 'package:auto_route/auto_route_annotations.dart';
import 'package:beautybook/screens/navigator/navigator.dart';
import 'package:beautybook/screens/sign/signin.dart';
import 'package:beautybook/screens/sign/signup.dart';
import 'package:beautybook/screens/splash/splash.dart';
import 'package:beautybook/screens/timeline/post_details_screen.dart';
import 'package:beautybook/screens/timeline/post_screen.dart';

@MaterialAutoRouter(routes: <AutoRoute>[
  AdaptiveRoute<SplashScreen>(page: SplashScreen, path: '/', initial: true),
  AdaptiveRoute<SignInScreen>(page: SignInScreen, path: '/signIn'),
  AdaptiveRoute<SignUpScreen>(page: SignUpScreen, path: '/signUp'),
  AdaptiveRoute<NavigatorScreen>(page: NavigatorScreen, path: '/home'),
  AdaptiveRoute<PostScreen>(page: PostScreen, path: '/post'),
  AdaptiveRoute<PostDetailsScreen>(
      page: PostDetailsScreen, path: '/post-etail'),
])
class $AppRouter {
  SplashScreen initialPage;
  SignInScreen signInScreen;
  SignUpScreen signUpScreen;
  NavigatorScreen navigatorScreen;
  PostScreen postScreen;
  PostDetailsScreen postDetailsScreen;
}
