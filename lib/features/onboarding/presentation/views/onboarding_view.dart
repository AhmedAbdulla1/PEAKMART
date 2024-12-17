import 'widgets/onboarding_view_body.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});
static  const String routeName = '/onboarding';
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: OnboardingViewBody(),
      ),
    );
  }
}
