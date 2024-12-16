import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:peakmart/core/resources/color_manager.dart';

import '../errv_options.dart';

class ErrVToastOptions extends ErrorViewerOptions {
  final ToastGravity? toastGravity;
  final Color? backGroundColor;
  final Color? textColor;

  const ErrVToastOptions({
    this.toastGravity,
    this.backGroundColor = ColorManager.textFormErrorBorder,
    this.textColor = ColorManager.white,
  });
}
