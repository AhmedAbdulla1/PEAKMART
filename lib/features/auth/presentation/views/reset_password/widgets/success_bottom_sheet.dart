import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/assets_manager.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/shared_widgets/buttons.dart';
import 'package:peakmart/features/auth/presentation/state_mang/otp_verfication_cubit/otp_verfication_cubit.dart';
import 'package:peakmart/features/auth/presentation/state_mang/reset_pass_cubit/cubit.dart';
import 'package:peakmart/features/auth/presentation/views/login/login_view.dart';
import 'package:timer_button/timer_button.dart';

class SuccessBottomSheet extends StatelessWidget {
  const SuccessBottomSheet(
      {super.key,
      this.restPassCubit,
      this.otpVerfictionCubit,
      required this.textMessage});
  final RestPassCubit? restPassCubit;
  final OtpVerfictionCubit? otpVerfictionCubit;
  final String textMessage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Success icon and message
          Image.asset(
            ImageAssets.success,
          ),
          const SizedBox(height: 10),
          const Text(
            AppStrings.success,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            textMessage,
            textAlign: TextAlign.center,
            style: getRegularStyle(
                fontSize: FontSize.s14, color: ColorManager.grey1),
          ),
          const SizedBox(height: 20),

          // Resend button with TimerButton
          otpVerfictionCubit != null
              ? Container()
              : TimerButton(
                  label: AppStrings.resend,
                  timeOutInSeconds: 30,
                  onPressed: () {
                    restPassCubit!.resend();
                  },
                  disabledColor: Colors.white,
                  color: Colors.white,
                  disabledTextStyle: getMediumStyle(
                      fontSize: FontSize.s16, color: ColorManager.grey1),
                  activeTextStyle: getMediumStyle(
                      fontSize: FontSize.s16, color: ColorManager.primary),
                  buttonType: ButtonType.textButton,
                ),

          const SizedBox(height: 20),

          // Login button
          CustomElevatedButtonWithoutStream(
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, LogInView.routeName); // Close the bottom sheet
            },
            text: AppStrings.login,
          ),
        ],
      ),
    );
  }
}
