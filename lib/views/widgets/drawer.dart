import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';

import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../controllers/auth/login.dart';
import '../localization/drawer.dart';
import '../pages.dart';
import '../responsive/dimensions.dart';

class DrawerItem {
  final String title;
  final IconData icon;
  final void Function(BuildContext context) onTap;
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
    title: Drawer_LocaleData.dashboard,
    icon: Icons.dashboard,
    onTap: (BuildContext context) {
      GoRouter.of(context).go(Pages.dashboard);
    },
    pagesToHighlight: [
      Pages.dashboard,
      Pages.section,
      Pages.createForm,
      Pages.form,
    ],
  ),
  DrawerItem(
    title: Drawer_LocaleData.notifications,
    icon: Icons.notifications,
    onTap: (BuildContext context) {
      GoRouter.of(context).push(Pages.notifications);
      _popDrawer(context);
    },
    pagesToHighlight: [Pages.notifications],
  ),
  if (!LoginController.isWorker)
    DrawerItem(
      title: Drawer_LocaleData.approve_forms,
      icon: Icons.checklist,
      onTap: (BuildContext context) {
        GoRouter.of(context).push(Pages.approveForms);
        _popDrawer(context);
      },
      pagesToHighlight: [Pages.approveForms],
    ),
  DrawerItem(
    title: Drawer_LocaleData.profile,
    icon: Icons.person,
    onTap: (BuildContext context) {
      GoRouter.of(context).push(Pages.profile);
      _popDrawer(context);
    },
    pagesToHighlight: [Pages.profile],
  ),
  if (!LoginController.isWorker)
    DrawerItem(
      title: Drawer_LocaleData.employees,
      icon: Icons.people,
      onTap: (BuildContext context) {
        GoRouter.of(context).push(Pages.employees);
        _popDrawer(context);
      },
      pagesToHighlight: [Pages.employees],
    ),
  if (!LoginController.isWorker)
    DrawerItem(
      title: Drawer_LocaleData.manage_forms,
      icon: Icons.list_alt,
      onTap: (BuildContext context) {
        GoRouter.of(context).push(Pages.manageForms);
        _popDrawer(context);
      },
      pagesToHighlight: [
        Pages.manageForms,
        Pages.manageCreateSection,
        Pages.manageCreateForm,
        Pages.manageManageForm,
      ],
    ),
  DrawerItem(
    title: Drawer_LocaleData.search,
    icon: Icons.search,
    onTap: (BuildContext context) {
      GoRouter.of(context).push(Pages.search);
      _popDrawer(context);
    },
    pagesToHighlight: [Pages.search],
  ),
  DrawerItem(
    title: Drawer_LocaleData.settings,
    icon: Icons.settings,
    onTap: (BuildContext context) {
      GoRouter.of(context).push(Pages.settings);
      _popDrawer(context);
    },
    pagesToHighlight: [Pages.settings],
  ),
  DrawerItem(
    title: Drawer_LocaleData.help,
    icon: Icons.help,
    onTap: (BuildContext context) {
      GoRouter.of(context).push(Pages.help);
      _popDrawer(context);
    },
    pagesToHighlight: [Pages.help],
  ),
  DrawerItem(
    title: Drawer_LocaleData.logout,
    icon: Icons.logout,
    onTap: (BuildContext context) {
      showDialog(
        context: context,
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
            title: Text(
              Drawer_LocaleData.smartshed.getString(context),
              style: const TextStyle(
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
          for (DrawerItem item in drawerItems) buildListTile(item, context),
        ],
      ),
    );
  }

  Widget buildListTile(DrawerItem item, BuildContext context) {
    final String currentRoute =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();

    bool isHighlighted = false;
    for (String page in item.pagesToHighlight) {
      if (currentRoute.startsWith(page)) {
        if (page == Pages.dashboard && currentRoute != Pages.dashboard) {
          continue;
        }

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
        item.title.getString(context),
        style: TextStyle(
          fontSize: 18,
          fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () => item.onTap(context),
    );
  }
}

void _popDrawer(BuildContext context) {
  if (!kIsWeb || MediaQuery.of(context).size.width < mobileWidth) {
    GoRouter.of(context).pop();
  }
}
