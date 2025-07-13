import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Bid_Mart/core/resources/string_manager.dart';
import 'package:Bid_Mart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:Bid_Mart/features/auth/presentation/state_mang/reset_pass_cubit/cubit.dart';
import 'package:Bid_Mart/features/auth/presentation/views/reset_password/widgets/forget_password_view_body.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});
  static const String routeName = '/forget-password';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.resetPassword,
        ),
        body: BlocProvider(
            create: (context) => RestPassCubit(),
            child: const ForgetPasswordViewBody()),
      ),
    );
  }
}
