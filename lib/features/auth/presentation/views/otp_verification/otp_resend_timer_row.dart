import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:timer_button/timer_button.dart';

import '../../../../../core/resources/style_manager.dart';

class OtpResendTimerRow extends StatelessWidget {
  const OtpResendTimerRow({super.key});

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
                  TimerButton(
                    label: AppStrings.resend,
                    timeOutInSeconds: 30,
                    onPressed: () {},
                    disabledColor: ColorManager.white,
                    color: ColorManager.white,
                    disabledTextStyle: getMediumStyle(
                        fontSize: FontSize.s16, color: ColorManager.darkGrey),
                    activeTextStyle: getMediumStyle(
                        fontSize: FontSize.s16, color: ColorManager.primary),
                    buttonType: ButtonType.textButton,
                  ),
                ],
              );
  }
}