import 'package:flutter/material.dart';

import './views/pages.dart';
import './controllers/routes/controller.dart';

class SmartShed extends StatelessWidget {
  const SmartShed({super.key});

  static Future<void> init() async {}

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SmartShed',
      initialRoute: Pages.splash,
      onGenerateRoute: RouteController.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
