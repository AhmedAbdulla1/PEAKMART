import 'dart:developer';

import 'package:Bid_Mart/core/error_ui/dialogs/custom_dialogs.dart';
import 'package:Bid_Mart/core/error_ui/toast.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/extentions.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:Bid_Mart/core/resources/values_manager.dart';
import 'package:Bid_Mart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:Bid_Mart/features/payment/domain/enum/enums.dart';
import 'package:Bid_Mart/features/payment/presentation/views/payment_dialog.dart';
import 'package:Bid_Mart/features/profile/domain/enitiy/user_info_entity.dart';
import 'package:Bid_Mart/features/profile/presentation/state_m/profile/cubit.dart';
import 'package:Bid_Mart/features/profile/presentation/views/balance/custom_text_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<ProfileCubit>(context).fetchProfileIfNeeded();
        },
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(AppPadding.p16),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: primaryColor),
              ),
              child: Column(
                children: [
                  Icon(Icons.account_balance_outlined,
                      size: AppSize.s100, color: primaryColor),
                  30.vGap,
                  _buildUserBankInfo(userInfo),
                  20.vGap,
                  CustomElevatedButtonWithoutStream(
                    text: "Change Bank Account",
                    height: AppSize.s45,
                    width: screenWidth * .75,
                    onPressed: () {}, // your action
                  ),
                  15.vGap,
                  Text(
                    "* New bank accounts take up to 2 days for verification.",
                    style: getMediumStyle(
                        fontSize: FontSize.s12, color: ColorManager.red),
                    textAlign: TextAlign.center,
                  ),
                  30.vGap,
                  Text("Available Balance:",
                      style: getBoldStyle(
                          fontSize: FontSize.s24, color: primaryColor)),
                  10.vGap,
                  Text("${userInfo.balance} \$",
                      style: getSemiBoldStyle(fontSize: FontSize.s28)),
                  30.vGap,
                  Row(
                    children: [
                      const Expanded(
                          child: _TransactionButton(type: "Withdraw")),
                      16.hGap,
                      const Expanded(
                          child: _TransactionButton(type: "Deposit")),
                    ],
                  ),
                  20.vGap,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserBankInfo(UserInfoEntity userInfo) {
    return Column(
      children: [
        CustomTextRow(
            title: "Bank Name: ",
            value: userInfo.sellerInfo['BANK_NAME'] ?? "N/A"),
        10.vGap,
        CustomTextRow(
            title: "Country: ",
            value: userInfo.sellerInfo['COUNTRY'] ?? "Afghanistan"),
        10.vGap,
        CustomTextRow(
            title: "IBAN: ", value: userInfo.sellerInfo['IBAN'] ?? "00"),
      ],
    );
  }
}

class _TransactionButton extends StatelessWidget {
  const _TransactionButton({required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButtonWithoutStream(
      text: type,
      height: AppSize.s45,
      onPressed: () async {
        await showCustomInputDialog(
          context: context,
          title: "Please enter the amount you want to ${type.toLowerCase()}",
          buttonText: "Submit",
          onSubmit: (value) async {
            if (value.isEmpty) {
              Toast.show("Please enter a valid amount",
                  backgroundColor: ColorManager.red);
              return;
            }

            Future.microtask(() {
              showCancelConfirmationDialog(
                context: context,
                icon: Icons.help_outline,
                title: type,
                content: "Are you sure you want to $type \$$value?",
                onConfirm: () {
                  Navigator.pop(context);
                 
                  // Call your logic here
                  showDialog(
                    context: context,
                    builder: (_) => PaymentDialog(
                      paymentProcess: PaymentProcess.deposit,
                      netPrice: double.tryParse(value) ?? 0,
                    ),
                  );
                },
              );
            });
          },
        );
      },
    );
  }
}

Future<void> showCustomInputDialog({
  required BuildContext context,
  required String title,
  required String buttonText,
  required Future<void> Function(String) onSubmit,
}) async {
  final controller = TextEditingController();
  final key = GlobalKey<FormState>();

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(title,
            style: getSemiBoldStyle(fontSize: FontSize.s20),
            textAlign: TextAlign.center),
        content: Form(
          key: key,
          child: TextFormField(
            autofocus: true,
            validator: (value) =>
                (value == null || value.isEmpty) ? 'Cannot be empty' : null,
            controller: controller,
            decoration: const InputDecoration(
                hintText: 'Enter', border: OutlineInputBorder()),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (key.currentState!.validate()) {
                final value = controller.text.trim();
                log("Amount = $value");
                Navigator.of(context).pop();

                onSubmit(value);
              }
            },
            child: Text(buttonText),
          ),
        ],
      );
    },
  );
}
