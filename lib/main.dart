import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'smartshed.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  await SmartShed.init();

  runApp(const SmartShed());
}
