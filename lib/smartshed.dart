import 'package:flutter/material.dart';

import './views/pages.dart';
import './constants/colors.dart';
import './controllers/routes/controller.dart';
import './controllers/auth/login.dart';

class SmartShed extends StatelessWidget {
  const SmartShed({super.key});

  static Future<void> init() async {
    LoginController.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartShed',
      initialRoute: Pages.splash,
      onGenerateRoute: RouteController.generateRoute,
      theme: ColorConstants.themeData,
      debugShowCheckedModeBanner: false,
    );
  }
}
