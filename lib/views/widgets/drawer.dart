import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../controllers/auth/login.dart';
import '../pages.dart';

class DrawerText {
  static const String dashboard = "Dashboard";
  static const String notifications = "Notifications";
  static const String manageForms = "Manage Forms";
  static const String profile = "Profile";
  static const String emp = "Employees";
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
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
            title: const Text(
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
          const Divider(
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
            leading: Icon(
              Icons.notifications,
              color: _isHighlighted(currentRoute, DrawerText.notifications)
                  ? ColorConstants.primary
                  : Colors.black,
            ),
            title: Text(
              DrawerText.notifications,
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    _isHighlighted(currentRoute, DrawerText.notifications)
                        ? FontWeight.bold
                        : FontWeight.normal,
              ),
            ),
            onTap: () {
              GoRouter.of(context).push(Pages.notifications);
              GoRouter.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.list_alt,
              color: _isHighlighted(currentRoute, DrawerText.manageForms)
                  ? ColorConstants.primary
                  : Colors.black,
            ),
            title: Text(
              DrawerText.manageForms,
              style: TextStyle(
                fontSize: 18,
                fontWeight: _isHighlighted(currentRoute, DrawerText.manageForms)
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
            onTap: () {
              GoRouter.of(context).push(Pages.manageForms);
              GoRouter.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: _isHighlighted(currentRoute, DrawerText.profile)
                  ? ColorConstants.primary
                  : Colors.black,
            ),
            title: Text(
              DrawerText.profile,
              style: TextStyle(
                fontSize: 18,
                fontWeight: _isHighlighted(currentRoute, DrawerText.profile)
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
            onTap: () {
              GoRouter.of(context).push(Pages.profile);
              GoRouter.of(context).pop();
            },
          ),
          if (!LoginController.isWorker)
            ListTile(
              leading: Icon(Icons.people,
                  color: _isHighlighted(currentRoute, DrawerText.emp)
                      ? ColorConstants.primary
                      : Colors.black),
              title: Text(
                DrawerText.emp,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: _isHighlighted(currentRoute, DrawerText.emp)
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              onTap: () {
                GoRouter.of(context).push(Pages.employees);
                GoRouter.of(context).pop();
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
          currentRoute.startsWith(Pages.createForm) ||
          currentRoute.startsWith(Pages.form);
    case DrawerText.notifications:
      return currentRoute.startsWith(Pages.notifications);
    case DrawerText.manageForms:
      return currentRoute.startsWith(Pages.manageForms);
    case DrawerText.profile:
      return currentRoute.startsWith(Pages.profile);
    case DrawerText.emp:
      return currentRoute.startsWith(Pages.employees);
    case DrawerText.logout:
      return currentRoute.startsWith(Pages.logout);
    default:
      return false;
  }
}
