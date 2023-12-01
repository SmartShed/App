import 'package:go_router/go_router.dart';

import '../../views/pages.dart';
import '../auth/login.dart';
import '../../models/form.dart';

class RouteController {
  static GoRouter router = generateRouter();

  static GoRouter generateRouter() {
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
          path: "${Pages.section}/:title",
          builder: (context, state) => SectionPage(
            title: state.pathParameters['title']!,
          ),
        ),
        GoRoute(
            path: Pages.createForm,
            builder: (context, state) {
              SmartShedForm? form = state.extra as SmartShedForm?;
              if (form == null) return const UnknownRoutePage();
              return CreateFormPage.fromForm(form);
            }),
        GoRoute(
          path: Pages.logout,
          builder: (context, state) => const LogoutPage(),
        ),
      ],
      errorBuilder: (context, state) => const UnknownRoutePage(),
      redirect: (context, state) async {
        if (state.uri.toString() == Pages.splash) {
          return null;
        }

        if (state.uri.toString() == Pages.register) {
          return null;
        }

        bool isLoggedIn = await LoginController.isLoggedIn;

        if (isLoggedIn &&
            (state.uri.toString() == Pages.login ||
                state.uri.toString() == Pages.register)) {
          return Pages.dashboard;
        }

        if (!isLoggedIn) {
          return Pages.login;
        }

        return null;
      },
    );
  }
}
