import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double startHeight = height * 0.1;

    return Drawer(
      backgroundColor: ColorConstants.bg,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: startHeight),
          ListTile(
            title: Text(
              "SmartShed",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: ColorConstants.primary,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.dashboard,
            ),
            title: const Text(
              "Dashboard",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/dashboard');
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
              Navigator.pushNamed(context, '/settings');
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
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
