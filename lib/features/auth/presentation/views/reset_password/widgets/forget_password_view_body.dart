import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/routes_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_text_form_field.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/cutom_elevated_button.dart';


class ForgetPasswordViewBody extends StatelessWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(29, 20, 29, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(
            flex: 1,),
          const CustomTextFormField(
              labelText: 'Phone number',
              hintText: 'Phone number',
              iconData: Icons.phone_rounded),
          const SizedBox(
            height: 20,
          ),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                text: '* ',
                style: getRegularStyle(
                        fontSize: FontSize.s16, color: ColorManager.red)
                    .copyWith(fontFamily: FontConstants.fontMontserratFamily),
              ),
              TextSpan(
                text:
                    'We will send you a message to set or reset your new password',
                style: getRegularStyle(
                        fontSize: FontSize.s14, color: ColorManager.darkGrey)
                    .copyWith(fontFamily: FontConstants.fontMontserratFamily),
              )
            ]),
          ),
         const SizedBox(
            height: 100,
         ),
          CustomElevatedButton(
            textButton: 'Submit',
            onPressed: () {
              Navigator.pushNamed(context, Routes.otpVerification);
            },

          ),
          Spacer(

          ),
        ],
      ),
    );
  }
}
