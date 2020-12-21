import 'package:auto_route/auto_route.dart';
import 'package:beautybook/core/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/loaders/decoders/yaml_decode_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'app_controller.dart';
import 'core/injectable/injectable.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final controller = getIt<AppController>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return MaterialApp(
        title: 'BeautyBook',
        theme: controller.theme,
        debugShowCheckedModeBanner: false,
        builder: ExtendedNavigator<AppRouter>(
          router: AppRouter(),
        ),
        localizationsDelegates: [
          FlutterI18nDelegate(
            translationLoader: FileTranslationLoader(
              useCountryCode: true,
              basePath: 'assets/i18n',
              decodeStrategies: [YamlDecodeStrategy()],
              fallbackFile: 'pt_BR',
              forcedLocale: const Locale('pt', 'BR'),
            ),
          ),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('pt', 'BR'),
          const Locale('en', 'US'),
        ],
      );
    });
  }
}
