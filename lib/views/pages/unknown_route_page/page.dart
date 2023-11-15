import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../pages.dart';

class UnknownRoutePage extends StatelessWidget {
  static const String routeName = '/unknown-route';

  const UnknownRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primary,
        title: const Text(
          'Unknown Route',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
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
              Navigator.pushNamedAndRemoveUntil(
                  context, Pages.dashboard, (Route<dynamic> route) => false);
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
