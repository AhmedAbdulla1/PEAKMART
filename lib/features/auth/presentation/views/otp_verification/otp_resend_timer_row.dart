import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:timer_button/timer_button.dart';

import '../../../../../core/resources/style_manager.dart';

class OtpResendTimerRow extends StatefulWidget {
  const OtpResendTimerRow(
      {super.key, required this.onPressed, this.autoStart = false});

  final bool autoStart;
  final Function() onPressed;

  @override
  State<OtpResendTimerRow> createState() => _OtpResendTimerRowState();
}

class _OtpResendTimerRowState extends State<OtpResendTimerRow> {
  late bool autoStart;

  @override
  void initState() {
    autoStart = widget.autoStart;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.otpNotReceived,
          overflow: TextOverflow.ellipsis,
          style: getSemiBoldStyle(
              fontSize: FontSize.s16, color: ColorManager.black),
        ),
        autoStart
            ? TimerButton(
                label: AppStrings.resend,
                timeOutInSeconds: 30,
                onPressed: widget.onPressed,
                disabledColor: ColorManager.white,
                color: ColorManager.white,
                disabledTextStyle: getMediumStyle(
                    fontSize: FontSize.s16, color: ColorManager.darkGrey),
                activeTextStyle: getMediumStyle(
                    fontSize: FontSize.s16, color: ColorManager.primary),
                buttonType: ButtonType.textButton,
              )
            : TextButton(
                onPressed: () => setState(() {
                      autoStart = true;
                      widget.onPressed();
                    }),
                child: Text(
                  AppStrings.resend,
                  style: getMediumStyle(
                      fontSize: FontSize.s16, color: ColorManager.primary),
                )),
      ],
    );
  }
}
