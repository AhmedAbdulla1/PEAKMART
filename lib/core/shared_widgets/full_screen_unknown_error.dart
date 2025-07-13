import 'package:flutter/material.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/extentions.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';

class FullScreenUnknownError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const FullScreenUnknownError({super.key,this.message = "Something went wrong", required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 80, color: Colors.red[400]),
          20.vGap,
          Text("Oops! Something went wrong",
              style: getMediumStyle(fontSize: 22)),
          10.vGap,
          Text(message,
              textAlign: TextAlign.center,
              style: getRegularStyle(
                  fontSize: 18, color: ColorManager.greyColor)),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            icon: const Icon(
              Icons.refresh,
              size: 25,
            ),
            label: const Text("Try Again"),
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}
