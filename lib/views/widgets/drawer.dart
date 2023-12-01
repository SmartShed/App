import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../pages.dart';

class DrawerText {
  static const String dashboard = "Dashboard";
  static const String settings = "Settings";
  static const String logout = "Logout";
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final String currentRoute =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();

    double height = MediaQuery.of(context).size.height;
    double startHeight = height * 0.05;

    return Drawer(
      backgroundColor: ColorConstants.bg,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: startHeight),
          ListTile(
            leading: Image.asset(
              ImageConstants.logo,
              height: 40,
            ),
            title: Text(
              "SmartShed",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: ColorConstants.primary,
              ),
            ),
            onTap: () {
              GoRouter.of(context).go(Pages.dashboard);
            },
          ),
          Divider(
            color: ColorConstants.primary,
            thickness: 2,
            indent: 10,
            endIndent: 10,
            height: 40,
          ),
          ListTile(
            leading: Icon(
              Icons.dashboard,
              color: _isHighlighted(currentRoute, DrawerText.dashboard)
                  ? ColorConstants.primary
                  : Colors.black,
            ),
            title: Text(
              DrawerText.dashboard,
              style: TextStyle(
                fontSize: 18,
                fontWeight: _isHighlighted(currentRoute, DrawerText.dashboard)
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
            onTap: () {
              GoRouter.of(context).go(Pages.dashboard);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
            ),
            title: const Text(
              DrawerText.settings,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              GoRouter.of(context).go('/settings');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: _isHighlighted(currentRoute, DrawerText.logout)
                  ? ColorConstants.primary
                  : Colors.black,
            ),
            title: Text(
              DrawerText.logout,
              style: TextStyle(
                fontSize: 18,
                fontWeight: _isHighlighted(currentRoute, DrawerText.logout)
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
            onTap: () {
              // Show logout dialog
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const LogoutPage();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

bool _isHighlighted(String currentRoute, String text) {
  switch (text) {
    case DrawerText.dashboard:
      return currentRoute.startsWith(Pages.dashboard) ||
          currentRoute.startsWith(Pages.section) ||
          currentRoute.startsWith(Pages.createForm);
    case DrawerText.settings:
      return currentRoute.startsWith('/settings');
    case DrawerText.logout:
      return currentRoute.startsWith(Pages.logout);
    default:
      return false;
  }
}
