import 'pages/create_form_page/page.dart';
import 'pages/dashboard_page/page.dart';
import 'pages/forgot_password_page/page.dart';
import 'pages/form_page/page.dart';
import 'pages/login_page/page.dart';
import 'pages/logout_page/page.dart';
import 'pages/profile_page/page.dart';
import 'pages/register_page/page.dart';
import 'pages/section_page/page.dart';
import 'pages/splash_page/page.dart';
import 'pages/employees_page/page.dart';
import 'pages/unknown_route_page/page.dart';

export 'pages/create_form_page/page.dart';
export 'pages/dashboard_page/page.dart';
export 'pages/forgot_password_page/page.dart';
export 'pages/form_page/page.dart';
export 'pages/login_page/page.dart';
export 'pages/logout_page/page.dart';
export 'pages/profile_page/page.dart';
export 'pages/register_page/page.dart';
export 'pages/section_page/page.dart';
export 'pages/splash_page/page.dart';
export 'pages/employees_page/page.dart';
export 'pages/unknown_route_page/page.dart';

class Pages {
  static const String splash = SplashPage.routeName;
  static const String dashboard = DashboardPage.routeName;
  static const String login = LoginPage.routeName;
  static const String register = RegisterPage.routeName;
  static const String forgotPassword = ForgotPasswordPage.routeName;
  static const String section = SectionPage.routeName;
  static const String createForm = CreateFormPage.routeName;
  static const String form = FormPage.routeName;
  static const String logout = LogoutPage.routeName;
  static const String profile = ProfilePage.routeName;
  static const String addEmployee = EmployeesPage.routeName;
  static const String unknownRoute = UnknownRoutePage.routeName;
}
