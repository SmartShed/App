import 'package:flutter/material.dart';

import '../../views/pages.dart';

class RouteController {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case Pages.splash:
        return _getPageRoute(const SplashPage());

      case Pages.dashboard:
        return _getPageRoute(const DashboardPage());

      case Pages.login:
        return _getPageRoute(const LoginPage());

      case Pages.register:
        return _getPageRoute(const RegisterPage());

      case Pages.section:
        return _getPageRoute(SectionPage.fromSectionJson(args!));

      default:
        return _getPageRoute(const UnknownRoutePage());
    }
  }

  static Route<dynamic> _getPageRoute(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
