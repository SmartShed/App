import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';

import 'constants/colors.dart';
import 'controllers/auth/login.dart';
import 'controllers/env/controller.dart';
import 'controllers/logger/log.dart';
import 'controllers/routes/router.dart';
import 'controllers/settings/settings.dart';
import 'controllers/smartshed/url.dart';

class SmartShed extends StatefulWidget {
  const SmartShed({super.key});

  static Future<void> init() async {
    GoRouter.optionURLReflectsImperativeAPIs = true;
    LoggerService.init(Level.off);
    await EnvController.init();
    await UrlController.setUrls();
    await UserSettingsController.init();
    await LoginController.init();
  }

  @override
  State<SmartShed> createState() => _SmartShedState();
}

class _SmartShedState extends State<SmartShed> {
  @override
  void initState() {
    UserSettingsController.setSetState(setState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SmartShed',
      theme: ColorConstants.themeData,
      debugShowCheckedModeBanner: false,
      routerDelegate: RouteController.router.routerDelegate,
      routeInformationParser: RouteController.router.routeInformationParser,
      routeInformationProvider: RouteController.router.routeInformationProvider,
      supportedLocales: FlutterLocalization.instance.supportedLocales,
      localizationsDelegates:
          FlutterLocalization.instance.localizationsDelegates,
    );
  }
}
