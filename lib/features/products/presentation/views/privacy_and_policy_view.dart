import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:peakmart/features/products/presentation/widgets/custom_scrollable_text.dart';

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
