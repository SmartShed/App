import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'constants/colors.dart';
import 'controllers/auth/login.dart';
import 'controllers/env/controller.dart';
import 'controllers/logger/log.dart';
import 'controllers/routes/controller.dart';
import 'utils/api/backend_url.dart';

class SmartShed extends StatelessWidget {
  const SmartShed({super.key});

  static Future init() async {
    GoRouter.optionURLReflectsImperativeAPIs = true;
    LoggerService.init(Level.all);
    await EnvController.init();
    await BackendUrlAPIHandler.setBackendUrl();
    LoginController.init();
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
