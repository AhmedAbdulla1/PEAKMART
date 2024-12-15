import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart' as ftoast;
import 'package:peakmart/core/resources/font_manager.dart';

class Toast {
  static void show(
    String msg, {
    int duration = 2000,
    ftoast.Toast androidDuration = ftoast.Toast.LENGTH_LONG,
    double fontSize = 16,
    ftoast.ToastGravity gravity = ftoast.ToastGravity.BOTTOM,
    Color? backgroundColor,
    Color? textColor,
  }) {
    ftoast.Fluttertoast.showToast(
      msg: msg,
      toastLength: androidDuration,
      gravity: gravity,
      timeInSecForIosWeb: duration,
      fontSize: fontSize,
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }

// static void cancelToast() {
// }
}
