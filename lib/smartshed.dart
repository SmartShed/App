import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'constants/colors.dart';
import 'controllers/auth/login.dart';
import 'controllers/env/controller.dart';
import 'controllers/logger/log.dart';
import 'controllers/routes/router.dart';
import 'controllers/smartshed/backend.dart';

class SmartShed extends StatelessWidget {
  const SmartShed({super.key});

  static Future init() async {
    GoRouter.optionURLReflectsImperativeAPIs = true;
    LoggerService.init(Level.off);
    await EnvController.init();
    // await BackendController.setBackendUrl();
    await BackendController.setBackendUrlToDefault();
    await LoginController.init();
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
    );
  }
}
