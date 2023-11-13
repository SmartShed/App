import 'pages/dashboard_page/page.dart';
import 'pages/splash_page/page.dart';
import 'pages/login_page/page.dart';
import 'pages/unknown_route_page/page.dart';

export 'pages/dashboard_page/page.dart';
export 'pages/splash_page/page.dart';
export 'pages/login_page/page.dart';
export 'pages/unknown_route_page/page.dart';

class Pages {
  static const String dashboard = DashboardPage.routeName;
  static const String unknownRoute = UnknownRoutePage.routeName;
  static const String splash = SplashPage.routeName;
  static const String login = LoginPage.routeName;
}
