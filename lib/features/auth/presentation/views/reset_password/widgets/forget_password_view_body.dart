import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/error_ui/error_viewer/toast/errv_toast_options.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/shared_widgets/buttons.dart';
import 'package:peakmart/core/shared_widgets/text_fields.dart';
import 'package:peakmart/features/auth/presentation/state_mang/reset_pass_cubit/cubit.dart';
import 'package:peakmart/features/auth/presentation/views/reset_password/view_model.dart';
import 'package:peakmart/features/auth/presentation/views/reset_password/widgets/success_bottom_sheet.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  final TextEditingController _emailController = TextEditingController();
  late  RestPassCubit _restPassCubit ;
  late ResetPasswordViewModel _viewModel;

  @override
  void initState() {
    _restPassCubit = context.read<RestPassCubit>();
    _restPassCubit.context = context;
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));
    _viewModel = ResetPasswordViewModel();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _restPassCubit.close();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(29, 20, 29, 0),
      child: BlocConsumer<RestPassCubit, ResetPassState>(
          listener: (context, state) {
            log('state is $state');
        if (state is ResetPassFailureState) {
          ErrorViewer.showError(
            errorViewerOptions: const ErrVToastOptions(),
            context: context,
            error: state.errors,
            callback: state.onRetry,
          );
        }
        if (state is ResetPassSuccessState) {
          print('success');
          showSuccessBottomSheet(context);
        }
      }, builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            CustomTextFormWithStream(
              stream: _viewModel.emailValidationStream,
              textEditingController: _emailController,
              hintText: AppStrings.email,
              prefixIcon: Icons.email,
              onComplete: () {
                _restPassCubit.resetPassword(email: _emailController.text);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Text.rich(
              TextSpan(children: [
                TextSpan(
                  text: '* ',
                  style: getRegularStyle(
                          fontSize: FontSize.s16, color: ColorManager.red)
                      .copyWith(fontFamily: FontConstants.fontMontserratFamily),
                ),
                TextSpan(
                  text: AppStrings.forgotPasswordHint,
                  style: getRegularStyle(
                          fontSize: FontSize.s14, color: ColorManager.darkGrey)
                      .copyWith(fontFamily: FontConstants.fontMontserratFamily),
                )
              ]),
            ),
            const SizedBox(
              height: 100,
            ),
            CustomElevatedButton(
              onPressed: () {
                _restPassCubit.resetPassword(
                  email: _emailController.text,
                );
              },
              stream: _viewModel.isEmailValid,
              text: AppStrings.submit,
            ),
            const Spacer(),
          ],
        );
      }),
    );
  }

  void showSuccessBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SuccessBottomSheet(
          restPassCubit: _restPassCubit,
        );
      },
    );
  }
}
