import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/extentions.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';

class NoProductsFoundedWidget extends StatelessWidget {
  const NoProductsFoundedWidget({
    super.key,
    required this.title,
    required this.buttonText,
    this.onButtonPressed,
    required this.onRefresh,
  });

  final String title;
  final String buttonText;
  final void Function()? onButtonPressed;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              Scaffold.of(context).appBarMaxHeightOrZero,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 50,
                  color: ColorManager.red,
                ),
                20.vGap,
                Text(
                  title,
                  style: getMediumStyle(fontSize: 26),
                  textAlign: TextAlign.center,
                ),
                20.vGap,
                ElevatedButton(
                  onPressed: onButtonPressed,
                  child: Text(buttonText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension _ScaffoldExtension on ScaffoldState {
  double get appBarMaxHeightOrZero =>
      hasAppBar ? AppBar().preferredSize.height : 0;
}
