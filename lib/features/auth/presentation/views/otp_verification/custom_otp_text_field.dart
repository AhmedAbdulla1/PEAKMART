import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';

class CustomOtpTextField extends StatelessWidget {
  const CustomOtpTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      focusedBorderColor: ColorManager.primary,
      numberOfFields: 4,
      fieldHeight: 75,
      fieldWidth: MediaQuery.of(context).size.width * .18,
      borderRadius: BorderRadius.circular(12),
      borderColor: ColorManager.grey1,
      textStyle:
          getRegularStyle(fontSize: FontSize.s32, color: ColorManager.black),
      showFieldAsBox: true,
      //runs when a code is typed in
      onCodeChanged: (String code) {
        //handle validation or checks here
      },
      //runs when every textfield is filled
      onSubmit: (String verificationCode) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Text("Done")));
        // showDialog(
        //   context: context,
        //   builder: (context) {
        //     return AlertDialog(
        //         title: Text(
        //           "Verification Code",
        //           style: getRegularStyle(
        //               fontSize: FontSize.s24, color: ColorManager.black),
        //         ),
        //         content: Text(
        //           'Code entered is $verificationCode',
        //           style: getRegularStyle(
        //               fontSize: FontSize.s18, color: ColorManager.black),
        //         ));
        //   },
        // );
      }, // end onSubmit
    );
  }
}
