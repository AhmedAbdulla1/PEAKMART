import 'package:flutter/material.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/extentions.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:Bid_Mart/core/resources/values_manager.dart';
import 'package:Bid_Mart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:Bid_Mart/features/profile/domain/enitiy/user_info_entity.dart';
import 'package:Bid_Mart/features/profile/presentation/views/balance/custom_text_row.dart';

import '../../../../../core/shared_widgets/buttons.dart';

class BalanceView extends StatelessWidget {
  const BalanceView({super.key, required this.userInfo});

  final UserInfoEntity userInfo;
  static const String routeName = "/balanceView";

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDarkMode = context.isDarkMode;
    final primaryColor =
        isDarkMode ? ColorManager.darkModePrimary : ColorManager.primary;

    return Scaffold(
      appBar: const CustomAppBar(title: "Balance"),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(AppPadding.p16),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: primaryColor, width: 1),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.account_balance_outlined,
                  size: AppSize.s100,
                  color: primaryColor,
                ),
                30.vGap,
                CustomTextRow(
                  title: "Bank Name: ",
                  value: userInfo.sellerInfo['BANK_NAME'] ?? "N/A",
                ),
                10.vGap,
                CustomTextRow(
                  title: "Country: ",
                  value: userInfo.sellerInfo['COUNTRY'] ?? "Afghanistan",
                ),
                10.vGap,
                CustomTextRow(
                  title: "IBAN: ",
                  value: userInfo.sellerInfo['IBAN'] ?? "00",
                ),
                20.vGap,
                CustomElevatedButtonWithoutStream(
                  text: "Change Bank Account",
                  height: AppSize.s45,
                  width: screenWidth * .75,
                  onPressed: () {},
                ),
                15.vGap,
                Text(
                  "* New bank accounts take up to 2 days for verification.",
                  style: getMediumStyle(
                    fontSize: FontSize.s12,
                    color: ColorManager.red,
                  ),
                  textAlign: TextAlign.center,
                ),
                30.vGap,
                Text(
                  "Available Balance:",
                  style: getBoldStyle(
                    fontSize: FontSize.s24,
                    color: primaryColor,
                  ),
                ),
                10.vGap,
                Text(
                  "${userInfo.balance} \$",
                  style: getSemiBoldStyle(
                    fontSize: FontSize.s28,
                  ),
                ),
                30.vGap,
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButtonWithoutStream(
                        text: "Withdraw",
                        height: AppSize.s45,
                        onPressed: () {},
                      ),
                    ),
                    16.hGap,
                    Expanded(
                      child: CustomElevatedButtonWithoutStream(
                        text: 'Deposit',
                        height: AppSize.s45,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                20.vGap,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
