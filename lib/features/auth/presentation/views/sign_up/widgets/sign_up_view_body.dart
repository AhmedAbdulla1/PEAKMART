import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/error_ui/error_viewer/toast/errv_toast_options.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/routes_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/features/auth/presentation/state_mang/register_cubit.dart/register_cubit.dart';
import 'package:peakmart/features/auth/presentation/views/sign_up/widgets/sign_up_build_widgets.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  @override
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            AppPadding.p29, 0, AppPadding.p29, AppPadding.p30),
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            // if (state is RegisterLoadingState) {
            //   log('loading state');
            //
            //   const Center(child: CircularProgressIndicator());
            // } else
            if (state is RegisterSuccessState) {
              log('success state');
              log(
                'Successful with an email is: ${email.toString()}, password is: ${password.toString()}, user name is: ${userName.toString()}, phone number is: ${phoneNumber.toString()}',
              );

              Navigator.pushNamed(context, Routes.otpVerification);
            }
            if (state is RegisterFailureState) {
              log('error state');
              ErrorViewer.showError(
                  errorViewerOptions: ErrVToastOptions(
                    textColor: Colors.white,
                    backGroundColor: ColorManager.textFormErrorBorder,
                  ),
                  context: context,
                  error: state.errors,
                  callback: state.onRetry);
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text(state.errors.toString()),
              //   ),
              // );
            }
          },
          builder: (context, state) {
            return const SingleChildScrollView(child: SignUpBuildWidgets());
          },
        ),
      ),
    );
  }
}
