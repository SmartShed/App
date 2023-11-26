import 'package:flutter/material.dart';

class ColorConstants {
  static final Color primary = fromHex('#128AA4');
  static final Color secondary = fromHex('#F4D35E');
  static final Color iconColor = fromHex('#FFFFFF');

  static final Color success = fromHex('#4BB543');
  static final Color warning = fromHex('#FFC107');
  static final Color error = fromHex('#FF0000');

  static const Color bg = Color(0xFFEEEEEE); // Grey[200]
  static const Color shadow = Color(0x33000000); // Black[200] with 20% opacity
  static Color? hover = Colors.grey[100];

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String toHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2, 8).toUpperCase()}';
  }

  static MaterialColor createMaterialColor(Color color) {
    final List<double> strengths = <double>[.05];
    final Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (final double strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(color.value, swatch);
  }

  static MaterialStateProperty<Color> createMaterialStateColor(Color color) {
    return MaterialStateProperty.resolveWith((states) => color);
  }

  static ThemeData get themeData {
    return ThemeData(
      primarySwatch: createMaterialColor(primary),
      primaryColor: primary,
      iconTheme: IconThemeData(color: iconColor),
      scaffoldBackgroundColor: bg,
      appBarTheme: AppBarTheme(
        backgroundColor: primary,
        iconTheme: IconThemeData(color: iconColor),
      ),
    );
  }
}
