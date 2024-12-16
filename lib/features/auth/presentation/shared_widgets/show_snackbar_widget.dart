import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';

void showCustomSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween, // لضمان وضع الأيقونة على اليمين
      children: [
        Expanded(
          child: Text(
            message,
            style: TextStyle(color: ColorManager.white, fontSize: FontSize.s16),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Icon(
          Icons.check_circle_outline,
          color: ColorManager.white,
        ),
      ],
    ),
    backgroundColor: ColorManager.primary,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    margin: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16, vertical: AppPadding.p10),
    duration: const Duration(milliseconds: 2500),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
