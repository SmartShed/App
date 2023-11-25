import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../pages.dart';

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
              color: currentRoute.startsWith(Pages.dashboard) ||
                      currentRoute.startsWith(Pages.section)
                  ? ColorConstants.primary
                  : Colors.black,
            ),
            title: Text(
              "Dashboard",
              style: TextStyle(
                fontSize: 18,
                fontWeight: currentRoute.startsWith(Pages.dashboard) ||
                        currentRoute.startsWith(Pages.section)
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
            onTap: () {
              // Navigator.pushNamed(context, Pages.dashboard);
              GoRouter.of(context).go(Pages.dashboard);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
            ),
            title: const Text(
              "Settings",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              // Navigator.pushNamed(context, '/settings');
              GoRouter.of(context).go('/settings');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
            ),
            title: const Text(
              "Logout",
              style: TextStyle(
                fontSize: 18,
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
