import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../views/pages.dart';
import '../auth/login.dart';

import '../../models/section.dart';

class RouteController {
  static GoRouter generateRoute() {
    // final args = settings.arguments as Map<String, dynamic>?;

    return GoRouter(
      initialLocation: Pages.splash,
      routes: [
        GoRoute(
          path: Pages.splash,
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: Pages.dashboard,
          builder: (context, state) => const DashboardPage(),
        ),
        GoRoute(
          path: Pages.login,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: Pages.register,
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: "${Pages.section}/:id/:name",
          builder: (context, state) => SectionPage(
            sectionId: state.pathParameters['id']!,
            sectionName: state.pathParameters['name']!,
          ),
        ),
        GoRoute(
          path: Pages.logout,
          builder: (context, state) => const LogoutPage(),
        ),
      ],
      errorBuilder: (context, state) => const UnknownRoutePage(),
      redirect: (context, state) async {
        // If splash page is requested, don't redirect
        if (state.uri.toString() == Pages.splash) {
          return null;
        }

        // If register page is requested, don't redirect
        if (state.uri.toString() == Pages.register) {
          return null;
        }

        bool isLoggedIn = await LoginController.isLoggedIn;
        if (!isLoggedIn) {
          return Pages.login;
        }
        return null;
      },
    );
  }
}


// import 'package:flutter/material.dart';

// import '../../views/pages.dart';
  
// class RouteController {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     final args = settings.arguments as Map<String, dynamic>?;

//     switch (settings.name) {
//       case Pages.splash:
//         return _getPageRoute(const SplashPage());

//       case Pages.dashboard:
//         return _getPageRoute(const DashboardPage());

//       case Pages.login:
//         return _getPageRoute(const LoginPage());

//       case Pages.register:
//         return _getPageRoute(const RegisterPage());

//       case Pages.section:
//         return _getPageRoute(SectionPage.fromSectionJson(args!));

//       case Pages.logout:
//         return _getPageRoute(const LogoutPage());

//       default:
//         return _getPageRoute(const UnknownRoutePage());
//     }
//   }

//   static Route<dynamic> _getPageRoute(Widget page) {
//     return MaterialPageRoute(builder: (_) => page);
//   }
// }
