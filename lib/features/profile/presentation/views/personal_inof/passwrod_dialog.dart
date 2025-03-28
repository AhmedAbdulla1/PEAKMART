import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';

Future<String?> showPasswordDialog(BuildContext context) async {
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;

  final result = await showDialog<String>(
    context: context,
    barrierDismissible: false, // Prevent dismissing by tapping outside
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(
              "Enter Password",
              style: getBoldStyle(
                fontSize: FontSize.s18,
                color: Colors.black,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
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
                SizedBox(height: 10.h),
                Text(
                  "Please enter your password to confirm changes.",
                  style: getRegularStyle(
                    fontSize: FontSize.s14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, null); // Return null if canceled
                },
                child: Text(
                  "Cancel",
                  style: getRegularStyle(
                    fontSize: FontSize.s16,
                    color: Colors.grey,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final password = passwordController.text.trim();

                  // Validation: Check if password is empty
                  if (password.isEmpty) {
                    ErrorViewer.showError(
                      context: context,
                      error: const AppErrors.customError(message: "Password cannot be empty"),
                      callback: () {},
                    );
                    return;
                  }

                  // Validation: Check if password is at least 8 characters long
                  if (password.length < 8) {
                    ErrorViewer.showError(
                      context: context,
                      error: const AppErrors.customError(
                          message: "Password must be at least 8 characters long"),
                      callback: () {},
                    );
                    return;
                  }
                  print(password);

                  // If validation passes, return the password
                  Navigator.pop(context, password); // Return the entered password
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8D5524),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  "Confirm",
                  style: getBoldStyle(
                    fontSize: FontSize.s16,
                    color: Colors.white,
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