import 'package:beautybook/app_controller.dart';
import 'package:beautybook/core/constants/globals.dart';
import 'package:beautybook/core/constants/theme.dart';
import 'package:beautybook/core/extensions/theme.dart';
import 'package:beautybook/core/helpers/theme/theme_helper.dart';
import 'package:beautybook/core/injectable/injectable.dart';
import 'package:beautybook/screens/sign/signin.controller.dart';
import 'package:beautybook/screens/sign/widgets/sigin_form.dart';
import 'package:beautybook/shared_widgets/base_state/base_state.dart';
import 'package:beautybook/shared_widgets/show_animations/background_unfocus/background_unfocus.dart';
import 'package:beautybook/shared_widgets/translate_button/translate_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends BaseState<SignInScreen>
    with TickerProviderStateMixin<SignInScreen> {
  final controller = getIt<SignInController>();
  final appController = getIt<AppController>();
  static const _baseTranslate = 'signin';

  bool initialized;
  bool initializedContainer;

  @override
  void initState() {
    super.initState();
    initialized = false;
    initializedContainer = false;

    Future.delayed(Duration(milliseconds: 250), () {
      setState(() {
        initialized = true;
      });
    });

    Future.delayed(Duration(milliseconds: 700), () {
      setState(() {
        initializedContainer = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final double _heightAppBar = AppBar().preferredSize.height;

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        extendBody: true,
        body: SafeArea(
          bottom: false,
          top: true,
          child: Observer(builder: (context) {
            return BackgroundUnfocus(
              backgroundColor: Theme.of(context).primaryColor,
              child: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    _clip(size: _size, heightAppBar: _heightAppBar),
                    _form(size: _size),
                    _logo(size: _size),
                    _skip(),
                    _signUp(size: _size, heightAppBar: _heightAppBar),
                  ],
                ),
              ),
            );
          }),
        ));
  }

  Widget _clip({Size size, double heightAppBar}) {
    return Container(
      height: size.height - heightAppBar,
      color: Theme.of(context).primaryColor,
      child: Container(
        height: size.height * 0.5,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: ClipPath(
                clipper: ClipHeaderLogin(),
                child: AnimatedContainer(
                  height: initialized ? size.height * 0.5 : size.height,
                  duration: Duration(milliseconds: 1200),
                  curve: Curves.ease,
                  color: Theme.of(context).backgroundColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _form({Size size}) {
    return Container(
      width: size.width,
      height: size.height,
      child: Center(
        child: AnimatedSize(
          vsync: this,
          duration: Duration(milliseconds: 600),
          curve: Curves.fastOutSlowIn,
          child: Container(
              alignment: FractionalOffset.center,
              width: initializedContainer ? size.width * 0.8 : 0,
              height: initializedContainer
                  ? size.height * 0.5 > 350
                      ? 350
                      : size.height * 0.5
                  : 0,
              decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .cardSignInColor(appController.appMode),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    initializedContainer
                        ? ThemeHelper.boxCard(context)
                        : BoxShadow()
                  ]),
              child: initializedContainer
                  ? SignInForm(
                      appMode: appController.appMode,
                    )
                  : Container()),
        ),
      ),
    );
  }

  _logo({Size size}) {
    final double _hLogo = (size.width * 0.4 / 400) * 154;

    return Positioned(
      top: 80,
      left: (size.width * 0.5) - (size.width * 0.5 / 2),
      child: Hero(
        tag: 'logo',
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          height: initializedContainer ? _hLogo : 0,
          width: initializedContainer ? size.width * 0.5 : 0,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(appController.appMode == AppMode.dark
                    ? 'assets/images/logo_bw.png'
                    : 'assets/images/logo.png'),
                fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }

  Widget _skip() {
    return Positioned(
      top: 10,
      right: 10,
      child: FlatButton(
        onPressed: () => controller.skip(),
        child: Text(translate('$_baseTranslate.skip'),
            style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .textColor(appController.appMode),
              fontSize: 17,
            )),
      ),
    );
  }

  Widget _signUp({Size size, double heightAppBar}) {
    return Positioned(
      bottom: heightAppBar,
      left: 0,
      child: Container(
        width: size.width,
        height: 80,
        child: Column(
          children: <Widget>[
            Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: () => controller.signUp(),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(translate('$_baseTranslate.signUp'),
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .textContrastColor)),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TranslateButton(
                  language: Language.portuguese,
                  size: 40,
                  iconColor: Colors.white,
                  callBack: () {
                    setState(() {});
                  },
                ),
                Padding(
                    padding: EdgeInsets.only(right: Constants.doublePadding)),
                TranslateButton(
                  language: Language.english,
                  size: 40,
                  iconColor: Colors.white,
                  callBack: () {
                    setState(() {});
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ClipHeaderLogin extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return oldClipper != null;
  }
}
