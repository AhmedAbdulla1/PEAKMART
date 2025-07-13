import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/features/main/main_view.dart';

class ErrorScreenHandler extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const ErrorScreenHandler({super.key, required this.errorDetails});

  String getTitle(Object exception) {
    final msg = exception.toString().toLowerCase();
    if (exception is SocketException || msg.contains("socket")) {
      return "No Internet Connection";
    } else if (msg.contains("firebase")) {
      return "Server Error";
    } else if (msg.contains("json")) {
      return "Data Format Error";
    } else if (msg.contains("timeout")) {
      return "Request Timed Out";
    } else {
      return "Unexpected Error";
    }
  }

  String getDescription(Object exception) {
    final msg = exception.toString().toLowerCase();
    if (exception is SocketException || msg.contains("socket")) {
      return "Please check your internet connection and try again.";
    } else if (msg.contains("firebase")) {
      return "There was a problem connecting to our servers.";
    } else if (msg.contains("json")) {
      return "An error occurred while processing data.";
    } else if (msg.contains("timeout")) {
      return "The request took too long. Try again later.";
    } else {
      return "We're working on fixing this issue. Please try again shortly.";
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final exception = errorDetails.exception;
    final themeColor = isDark ? Colors.white : Colors.black;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/error_animation.json',
              width: 260.w,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 32.h),
            Text(
              getTitle(exception),
              style: getBoldStyle(fontSize: FontSize.s24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            Text(
              getDescription(exception),
              style: getRegularStyle(
                fontSize: FontSize.s16,
                color: isDark ? Colors.grey[400] : Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: themeColor),
                foregroundColor: themeColor,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              icon: const Icon(
                Icons.home_outlined,
                size: 26,
              ),
              label: Text(
                "Go to Home",
                style: getMediumStyle(fontSize: FontSize.s16),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, MainView.routeName,
                    arguments: 0);
              },
            ),
          ],
        ),
      ),
    );
  }
}
