import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/error_ui/dialogs/show_dialog.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/error_ui/error_viewer/toast/errv_toast_options.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/auth/domain/entity/register_entity.dart';
import 'package:peakmart/features/auth/presentation/state_mang/register_cubit.dart/register_cubit.dart';
import 'package:peakmart/features/auth/presentation/views/otp_verification/otp_verification.dart';
import 'package:peakmart/features/auth/presentation/views/sign_up/widgets/sign_up_build_widgets.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            AppPadding.p29, 0, AppPadding.p29, AppPadding.p30),
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterLoadingState) {
              ShowDialog().showElasticDialog(
                context: context,
                builder: (context) => const WaitingWidget(),
                barrierDismissible: false,
              );
            
            }
            if (state is RegisterSuccessState) {
              log('success state');
              // showCustomSnackBar(context, 'Successfully registered');
              log(
                'Successful with an email is: ${email.toString()}, password is: ${password.toString()}, user name is: ${userName.toString()}, phone number is: ${phoneNumber.toString()}',
              );
              RegisterEntity registerEntity = state.registerEntity;
              log('Register entity is: ${registerEntity.toString()}');
              Navigator.pushNamed(
                context,
                OtpVerification.routeName,
              );
            }
            if (state is RegisterFailureState) {
              log('error state');
              ErrorViewer.showError(
                  errorViewerOptions: ErrVToastOptions(
                    textColor: ColorManager.white,
                    backGroundColor: ColorManager.primary,
                  ),
                  context: context,
                  error: state.errors,
                  callback: state.onRetry);
            }
          },
          builder: (context, state) {
            return const SingleChildScrollView(
              child: SignUpBuildWidgets(),
            );
          },
        ),
      ),
    );
  }
}
