import 'package:flutter/material.dart';
import 'package:Bid_Mart/core/resources/string_manager.dart';
import 'package:Bid_Mart/core/resources/values_manager.dart';
import 'package:Bid_Mart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:Bid_Mart/features/products/presentation/widgets/custom_scrollable_text.dart';

class PrivacyAndPolicyView extends StatelessWidget {
  const PrivacyAndPolicyView({super.key});
  static const String routeName = "/privacy_and_policy_view";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: AppStrings.privacyPolicy),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p16, vertical: AppPadding.p12),
        child:
            CustomScrollableText(text: AppStrings.privacyAndPolicyDescription),
      ),
    );
  }
}
