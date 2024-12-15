import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:peakmart/features/auth/presentation/views/otp_verification/otp_verification_body.dart';

class OtpVerification extends StatelessWidget {
  const OtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.white,
        appBar: const CustomAppBar(
          title: 'OTP',
        ),
        body: const OtpVerificationBody(),
      ),
    );
  }
}