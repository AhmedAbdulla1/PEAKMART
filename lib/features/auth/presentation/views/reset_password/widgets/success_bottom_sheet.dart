import 'package:flutter/material.dart';
import 'package:Bid_Mart/core/resources/assets_manager.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/extentions.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/string_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:Bid_Mart/core/shared_widgets/buttons.dart';
import 'package:Bid_Mart/features/auth/presentation/state_mang/otp_verfication_cubit/otp_verfication_cubit.dart';
import 'package:Bid_Mart/features/auth/presentation/state_mang/reset_pass_cubit/cubit.dart';
import 'package:Bid_Mart/features/auth/presentation/views/login/login_view.dart';
import 'package:Bid_Mart/features/main/main_view.dart';
import 'package:timer_button/timer_button.dart';

class SuccessBottomSheet extends StatelessWidget {
  const SuccessBottomSheet(
      {super.key,
      this.restPassCubit,
      this.otpVerfictionCubit,
      required this.textMessage,
      this.isUsedWithProductDetails});
  final RestPassCubit? restPassCubit;
  final bool? isUsedWithProductDetails;
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
          10.vGap,
          const Text(
            AppStrings.success,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          10.vGap,
          Text(
            textMessage,
            textAlign: TextAlign.center,
            style: getRegularStyle(
                fontSize: FontSize.s14,
                color: context.isDarkMode
                    ? ColorManager.grey
                    : ColorManager.grey1),
          ),
          20.vGap,
          // Resend button with TimerButton
          (otpVerfictionCubit != null || isUsedWithProductDetails == true)
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

          20.vGap,
          // Login button
          (otpVerfictionCubit == null && isUsedWithProductDetails == false)
              ? CustomElevatedButtonWithoutStream(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, LogInView.routeName);
                  },
                  text: AppStrings.login,
                )
              : CustomElevatedButtonWithoutStream(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, MainView.routeName);
                  },
                  text: AppStrings.Continue,
                )
        ],
      ),
    );
  }
}
