import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../pages.dart';

class UnknownRoutePage extends StatelessWidget {
  static const String routeName = '/unknown-route';

  const UnknownRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ImageConstants.logo,
              width: 150,
            ),
            const SizedBox(height: 10),
            Image.asset(
              ImageConstants.logoText,
              width: 250,
            ),
            const SizedBox(height: 40),
            Text(
              "404",
              style: TextStyle(
                fontSize: 120,
                fontWeight: FontWeight.bold,
                color: ColorConstants.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Page not found",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorConstants.primary,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => GoRouter.of(context).go(Pages.dashboard),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  "Go to dashboard",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
