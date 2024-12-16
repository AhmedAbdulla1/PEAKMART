import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';

class CustomOtpTextField extends StatelessWidget {
  const CustomOtpTextField({
    super.key, this.onSubmit,
  });
final Function(String)? onSubmit;
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
      onCodeChanged: (String code) {},
      onSubmit: onSubmit
      //(String verificationCode) {
      //   debugPrint("Code submitted: $verificationCode");
       
      //   // Navigator.push(context,
      //   //     MaterialPageRoute(builder: (context) => const Text("Done")));
      // },
    );
  }
}
