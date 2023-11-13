import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants/colors.dart';

class ToastController {
  static void show(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      backgroundColor: ColorConstants.success,
      webShowClose: true,
      webBgColor: ColorConstants.toHex(ColorConstants.success),
      timeInSecForIosWeb: 2,
    );
  }

  static void warning(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.black,
      backgroundColor: ColorConstants.warning,
      webShowClose: true,
      webBgColor: ColorConstants.toHex(ColorConstants.warning),
      timeInSecForIosWeb: 2,
    );
  }

  static void error(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      backgroundColor: ColorConstants.error,
      webShowClose: true,
      webBgColor: ColorConstants.toHex(ColorConstants.error),
      timeInSecForIosWeb: 2,
    );
  }
}
