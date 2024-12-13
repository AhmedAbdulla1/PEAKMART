import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:peakmart/features/auth/presentation/views/reset_password/widgets/change_password_body.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});
  static const String routeName = '/change-password';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.white,
        appBar: const CustomAppBar(
          title: 'Change Password',
        ),
        body: const ChangePasswordBody(),
      ),
    );
  }
}
