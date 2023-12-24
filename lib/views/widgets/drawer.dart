import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../controllers/auth/login.dart';
import '../pages.dart';

late BuildContext globalContext;

class DrawerItem {
  final String title;
  final IconData icon;
  final void Function() onTap;
  final List<String> pagesToHighlight;

  const DrawerItem({
    required this.title,
    required this.icon,
    required this.onTap,
    this.pagesToHighlight = const [],
  });
}

List<DrawerItem> drawerItems = [
  DrawerItem(
    title: "Dashboard",
    icon: Icons.dashboard,
    onTap: () {
      GoRouter.of(globalContext).go(Pages.dashboard);
    },
    pagesToHighlight: [
      Pages.dashboard,
      Pages.section,
      Pages.createForm,
      Pages.form,
    ],
  ),
  DrawerItem(
    title: "Notifications",
    icon: Icons.notifications,
    onTap: () {
      GoRouter.of(globalContext).push(Pages.notifications);
      GoRouter.of(globalContext).pop();
    },
    pagesToHighlight: [Pages.notifications],
  ),
  if (!LoginController.isWorker)
    DrawerItem(
      title: "Approve Forms",
      icon: Icons.checklist,
      onTap: () {
        GoRouter.of(globalContext).push(Pages.approveForms);
        GoRouter.of(globalContext).pop();
      },
      pagesToHighlight: [Pages.approveForms],
    ),
  DrawerItem(
    title: "Profile",
    icon: Icons.person,
    onTap: () {
      GoRouter.of(globalContext).push(Pages.profile);
      GoRouter.of(globalContext).pop();
    },
    pagesToHighlight: [Pages.profile],
  ),
  if (!LoginController.isWorker)
    DrawerItem(
      title: "Employees",
      icon: Icons.people,
      onTap: () {
        GoRouter.of(globalContext).push(Pages.employees);
        GoRouter.of(globalContext).pop();
      },
      pagesToHighlight: [Pages.employees],
    ),
  if (!LoginController.isWorker)
    DrawerItem(
      title: "Manage Forms",
      icon: Icons.list_alt,
      onTap: () {
        GoRouter.of(globalContext).push(Pages.manageForms);
        GoRouter.of(globalContext).pop();
      },
      pagesToHighlight: [
        Pages.manageForms,
        Pages.manageCreateSection,
        Pages.manageCreateForm,
        Pages.manageManageForm,
      ],
    ),
  DrawerItem(
    title: "Logout",
    icon: Icons.logout,
    onTap: () {
      showDialog(
        context: globalContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const LogoutPage();
        },
      );
    },
    pagesToHighlight: [Pages.logout],
  ),
];

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    globalContext = context;
    double height = MediaQuery.of(context).size.height;
    double startHeight = height * 0.075;

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
          for (DrawerItem item in drawerItems) buildListTile(item),
        ],
      ),
    );
  }

  Widget buildListTile(DrawerItem item) {
    final String currentRoute = GoRouter.of(globalContext)
        .routeInformationProvider
        .value
        .uri
        .toString();

    bool isHighlighted = false;
    for (String page in item.pagesToHighlight) {
      if (currentRoute.startsWith(page)) {
        isHighlighted = true;
        break;
      }
    }

    return ListTile(
      leading: Icon(
        item.icon,
        color: isHighlighted ? ColorConstants.primary : Colors.black,
      ),
      title: Text(
        item.title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: item.onTap,
    );
  }
}
