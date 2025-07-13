import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Bid_Mart/app/app_prefs.dart';
import 'package:Bid_Mart/app/di.dart';
import 'package:Bid_Mart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/extentions.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/core/resources/theme/extentaions/app_theme_ext.dart';

Future<String?> showPasswordDialog(BuildContext context) async {
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  AppPreferences appPreferences = instance<AppPreferences>();

  final result = await showDialog<String>(
    context: context,
    barrierDismissible: false, // Prevent dismissing by tapping outside
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(
              "Enter Password",
              textAlign: TextAlign.center,
              style: getBoldStyle(
                fontSize: FontSize.s22,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  style: getRegularStyle(
                    color: context.isDarkMode
                        ? ColorManager.darkModePrimary
                        : ColorManager.primary,
                    fontSize: FontSize.s16,
                  ),
                  autofocus: true,
                  controller: passwordController,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    labelText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    ),
                  ),
                ),
                10.vGap,
                Text(
                  "Please enter your password to confirm changes.",
                  style: getRegularStyle(
                    fontSize: FontSize.s15,
                    color: context.isDarkMode
                        ? ColorManager.greyColor
                        : ColorManager.darkGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  final password = passwordController.text.trim();

                  // Validation: Check if password is empty
                  if (password.isEmpty) {
                    ErrorViewer.showError(
                      context: context,
                      error: const AppErrors.customError(
                          message: "Password cannot be empty"),
                      callback: () {},
                    );
                    return;
                  }

                  // Validation: Check if password is at least 8 characters long
                  if (password.length < 8) {
                    ErrorViewer.showError(
                      context: context,
                      error: const AppErrors.customError(
                          message:
                              "Password must be at least 8 characters long"),
                      callback: () {},
                    );
                    return;
                  }
                  if (password != appPreferences.getUserPassword()) {
                    ErrorViewer.showError(
                      context: context,
                      error: const AppErrors.customError(
                          message: "Password is incorrect"),
                      callback: () {},
                    );
                    return;
                  }
                  print(password);

                  // If validation passes, return the password
                  Navigator.pop(
                      context, password); // Return the entered password
                },
                child: Text(
                  "Confirm",
                  style: getBoldStyle(
                    fontSize: FontSize.s16,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, null); // Return null if canceled
                },
                child: Text(
                  "Cancel",
                  style: getRegularStyle(
                    fontSize: FontSize.s16,
                    color: context.isDarkMode
                        ? ColorManager.greyColor
                        : ColorManager.darkGrey,
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
  print("Result: $result");
  // passwordController.dispose(); // Dispose of the controller after use
  return result;
}
