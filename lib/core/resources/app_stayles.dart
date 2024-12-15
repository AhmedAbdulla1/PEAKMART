import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';

class AppStayles {
  static TextStyle style16Medium =
      TextStyle(fontSize: FontSize.s16, fontWeight: FontWeightManager.medium);
  static TextStyle style12Medium =
      TextStyle(fontSize: FontSize.s12, fontWeight: FontWeightManager.medium);
  static TextStyle style16Bold = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
  );
  static TextStyle style31Bold = TextStyle(
      fontSize: 31,
      fontWeight: FontWeightManager.bold,
      color: ColorManager.primary);
}
