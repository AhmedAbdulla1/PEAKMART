import 'package:flutter/material.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/resources/string_manager.dart';

void passNotTheSame(BuildContext context) {
  ErrorViewer.showCustomError(context, AppStrings.passwordNotTheSame);
}
