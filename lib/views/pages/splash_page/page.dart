import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../pages.dart';
import '../../../constants/images.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = '/';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () async {
      // Navigator.pushNamedAndRemoveUntil(
      //     context, routeName, (Route<dynamic> route) => false);
      GoRouter.of(context).go(Pages.dashboard);
    });
  }

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
              width: 200,
            ),
            const SizedBox(height: 20),
            Image.asset(
              ImageConstants.logoText,
              width: 300,
            ),
          ],
        ),
      ),
    );
  }
}
