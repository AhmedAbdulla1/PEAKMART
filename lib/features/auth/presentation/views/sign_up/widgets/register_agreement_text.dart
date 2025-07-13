import 'package:flutter/material.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/string_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/core/resources/theme/extentaions/app_theme_ext.dart';

class RegisterAgreementText extends StatelessWidget {
  const RegisterAgreementText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: AppStrings.byClicking,
            style: getRegularStyle(
              fontSize: FontSize.s15,
              color: context.isDarkMode
                  ? ColorManager.grey
                  : const Color(0xff676767),
            ),
          ),
          TextSpan(
            text: AppStrings.register,
            style: getRegularStyle(
                fontSize: FontSize.s15,
                color: context.isDarkMode
                    ? ColorManager.darkModePrimary
                    : ColorManager.primary),
          ),
          TextSpan(
            text: AppStrings.agreeText,
            style: getRegularStyle(
              fontSize: FontSize.s15,
              color: context.isDarkMode
                  ? ColorManager.grey
                  : const Color(0xff676767),
            ),
          )
        ],
      ),
    );
  }
}
