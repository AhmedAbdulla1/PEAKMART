import 'package:flutter/material.dart';
import 'package:Bid_Mart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:Bid_Mart/core/resources/string_manager.dart';

void passNotTheSame(BuildContext context) {
  ErrorViewer.showCustomError(context, AppStrings.passwordNotTheSame);
}
