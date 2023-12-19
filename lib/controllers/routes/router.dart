import 'package:go_router/go_router.dart';

import '../../models/opened_form.dart';
import '../../models/unopened_form.dart';
import '../../models/user.dart';
import '../../views/pages.dart';
import '../auth/login.dart';

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
          path: Pages.profile,
          builder: (context, state) {
            SmartShedUser? user = state.extra as SmartShedUser?;
            user ??= LoginController.user!;
            return ProfilePage(user: user);
          },
        ),
        GoRoute(
          path: Pages.forgotPassword,
          builder: (context, state) => const ForgotPasswordPage(),
        ),
        GoRoute(
          path: Pages.notifications,
          builder: (context, state) => const NotificationsPage(),
        ),
        GoRoute(
          path: Pages.manageForms,
          builder: (context, state) => const ManageFormsPage(),
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
            SmartShedUnopenedForm? form = state.extra as SmartShedUnopenedForm?;
            if (form == null) return const UnknownRoutePage();
            return CreateFormPage.fromForm(form);
          },
        ),
        GoRoute(
          path: "${Pages.form}/:id",
          builder: (context, state) {
            SmartShedOpenedForm? form = state.extra as SmartShedOpenedForm?;
            return FormPage(
              id: state.pathParameters['id']!,
              data: form,
            );
          },
        ),
        GoRoute(
          path: Pages.logout,
          builder: (context, state) => const LogoutPage(),
        ),
        GoRoute(
          path: Pages.employees,
          builder: (context, state) => const EmployeesPage(),
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

        if (state.uri.toString() == Pages.forgotPassword) {
          return null;
        }

        bool isLoggedIn = await LoginController.isLoggedIn;

        if (!isLoggedIn) {
          return Pages.login;
        }

        if (state.uri.toString() == Pages.login ||
            state.uri.toString() == Pages.register) {
          return Pages.dashboard;
        }

        if (state.uri.toString() == Pages.employees &&
            LoginController.isWorker) {
          return Pages.dashboard;
        }

        return null;
      },
    );
  }
}
