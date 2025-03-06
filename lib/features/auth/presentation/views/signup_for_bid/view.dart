import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/error_ui/dialogs/show_dialog.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:peakmart/features/auth/presentation/state_mang/signup_for_bid/cubit.dart';
import 'package:peakmart/features/auth/presentation/state_mang/user_info_cubit/user_info_cubit.dart';
import 'package:peakmart/features/auth/presentation/views/otp_verification/otp_verification.dart';
import 'package:peakmart/features/auth/presentation/views/signup_for_bid/additional_details.dart';
import 'package:peakmart/features/auth/presentation/views/signup_for_bid/main_info.dart';

class SignUpForBidView extends StatefulWidget {
  static const String routeName = '/signUpForBid';

  const SignUpForBidView({super.key});

  @override
  State<SignUpForBidView> createState() => _SignUpForBidViewState();
}

class _SignUpForBidViewState extends State<SignUpForBidView> {
  late SignUpForBidCubit _signUpForBidCubit;

  @override
  void initState() {
    _signUpForBidCubit = SignUpForBidCubit();
    _signUpForBidCubit.context = context;
    super.initState();
  }

  int index = 0;
  List<Widget> screens = [
    const MainInfo(),
    const AdditionalDetails(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpForBidCubit>(
      create: (context) => _signUpForBidCubit,
      child: Scaffold(
        // backgroundColor: Color(0xFFE545E5),
        appBar: const CustomAppBar(title: "Sign Up For Bid"),
        body: Padding(
          padding: const EdgeInsets.only(
            left: AppPadding.p20,
            right: AppPadding.p20,
          ),
          child: BlocConsumer<SignUpForBidCubit, SignUpState>(
              listener: (context, state) {
            if (state is SignUpFailure) {
              Navigator.pop(context);
              ErrorViewer.showError(
                  context: context, error: state.error, callback: () {});
            }
            if (state is SignUpDetailsFailure) {
              Navigator.pop(context);
              ErrorViewer.showError(
                  context: context, error: state.error, callback: () {});
            }
            if (state is SignUpSuccess) {
              Navigator.pop(context);
              index = 1;
            }
            if (state is SignUpDetailsLoading || state is SignUpLoading) {
              ShowDialog().showElasticDialog(
                  context: context,
                  builder: (context) => const WaitingWidget(),
                  barrierDismissible: true);
            }
            if (state is SignUpDetailsSuccess) {
              // log("in sign up for owner register entity: ${UserInfoCubit.entity.toString()}");
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                OtpVerification.routeName,
                arguments: {
                  'verificationType': VerificationType.watsApp,
                  // 'registerEntity': UserInfoCubit.entity,
                },
              );
            }
            if (state is SignUpLoading) {
              ShowDialog().showElasticDialog(
                  context: context,
                  builder: (context) => const WaitingWidget(),
                  barrierDismissible: false);
            }
          }, builder: (context, state) {
            return ListView(
              children: [
                screens[index],
              ],
            );
          }),
        ),
      ),
    );
  }
}
