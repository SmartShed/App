import 'package:flutter/material.dart';

import './constants/colors.dart';
import './controllers/routes/controller.dart';
import './controllers/auth/login.dart';

class SmartShed extends StatelessWidget {
  const SmartShed({super.key});

  static void init() {
    LoginController.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SmartShed',
      routerConfig: RouteController.generateRouter(),
      theme: ColorConstants.themeData,
      debugShowCheckedModeBanner: false,
    );
  }
}
