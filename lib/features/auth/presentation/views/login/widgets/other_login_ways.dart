import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/features/auth/presentation/state_mang/social_sign_in_cubit/social_sign_in_cubit.dart';
import 'package:peakmart/features/auth/presentation/views/login/widgets/login_divider_widget.dart';
import 'package:peakmart/features/auth/presentation/views/login/widgets/other_login_method_shape.dart';
import 'package:peakmart/features/main/main_view.dart';

class OtherLoginWays extends StatelessWidget {
  const OtherLoginWays({super.key});
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    return Column(
      children: [
        const LoginDividerWidget(),
        20.vGap,
        BlocConsumer<SignInWithSocialCubit, SignInWithSocialState>(
          listener: (context, state) {
            if (state is SignInWithSocialSuccessState) {
              isLoading = false;

              log("in google User signed in successfully.");
              Navigator.pushReplacementNamed(context, MainView.routeName);
            }
            if (state is SignInWithSocialFailureState) {
              isLoading = false;
              ErrorViewer.showCustomError(context, state.errorMessage);
              log("in google User signed in failed. ${state.errorMessage}");
            }
          },
          builder: (context, state) {
            if (state is SignInWithSocialLoadingState) {
              isLoading = true;
              log("in google User loading.");
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OtherLoginMethodsShape(
                  isLoading: isLoading,
                  onTap: () {
                    String locale =
                        Localizations.localeOf(context).languageCode;
                    FirebaseAuth.instance.setLanguageCode(locale);
                    BlocProvider.of<SignInWithSocialCubit>(context)
                        .signInWithGoogle();
                  },
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
