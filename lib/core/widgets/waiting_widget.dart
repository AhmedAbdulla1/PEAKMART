import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';

class WaitingWidget extends StatelessWidget {
  const WaitingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: ColorManager.primary,
      ),
    );
  }
}

class TextWaitingWidget extends StatelessWidget {
  final String text;
  final Duration? pause;
  final Color textColor;

  const TextWaitingWidget(this.text,
      {super.key, this.pause, this.textColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      text,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: 50.sp,
      ),
    ));
  }
}
