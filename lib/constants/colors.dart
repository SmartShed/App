import 'package:flutter/material.dart';

class ColorConstants {
  static final Color primary = fromHex('#128AA4');
  static final Color secondary = fromHex('#DAEEF1');
  static final Color iconColor = fromHex('#A36C33');

  static final Color success = fromHex('#4BB543');
  static final Color warning = fromHex('#FFC107');
  static final Color error = fromHex('#FF0000');

  static const Color bg = Color(0xFFEEEEEE); // Grey[200]

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String toHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2, 8).toUpperCase()}';
  }
}
