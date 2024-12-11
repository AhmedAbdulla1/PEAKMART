import 'package:flutter/material.dart';
import 'package:peakmart/app/resources/color_manager.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      // width: 100,
      duration: const Duration(seconds: 2),
      backgroundColor: ColorManager.grey1,
      content: Center(
          child: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      )),
    ),
  );
}
