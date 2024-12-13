import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/routes_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_text_form_field.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/cutom_elevated_button.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(29, 20, 29, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(
            flex: 1,
          ),
          Text(
            'Your new password must be different from the previously used password',
            style: getRegularStyle(
                fontSize: FontSize.s12, color: ColorManager.grey1),
          ),
          Spacer(
            flex: 1,),
          TextFormField(
            obscureText: obscureText,
            decoration: InputDecoration(
                labelText: 'Enter new password',
                suffix: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye_outlined,
                    color: ColorManager.grey1,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;},);
                  },
                ),
                prefixIcon: Icon(
                  Icons.lock,
                  color: ColorManager.grey1,
                )),
          ),
          SizedBox(
            height:AppSize.s20.h,),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Confirm new password',
                suffix: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye_outlined,
                    color: ColorManager.grey1,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;},);
                  },
                ),
                prefixIcon: Icon(
                  Icons.lock,
                  color: ColorManager.grey1,
                )),
          ),
          const Spacer(
            flex: 8,
          ),
          CustomElevatedButton(
            textButton: 'Save',
            onPressed: () {
              Navigator.pushNamed(context, Routes.mainScreen);
            },
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
