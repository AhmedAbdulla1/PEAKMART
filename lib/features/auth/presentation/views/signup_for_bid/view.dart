import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/app/app.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/core/shared_widgets/buttons.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:peakmart/features/auth/presentation/state_mang/signup_for_bid/cubit.dart';
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
    super.initState();
  }

  int index = 0;
  List<Widget> screens = [
    const MainInfo(),
    AdditionalDetails(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpForBidCubit>(
      create: (context) => _signUpForBidCubit,
      child: Scaffold(
        // backgroundColor: Color(0xFFE545E5),
        appBar: CustomAppBar(title: "Sign Up For Bid"),
        body: Padding(
          padding: const EdgeInsets.only(
              left: AppPadding.p20,
              right: AppPadding.p20,
              bottom: AppPadding.p65),
          child: BlocConsumer<SignUpForBidCubit, SignUpState>(
              listener: (context, state) {
            if (state is SignUpFailure) {
              ErrorViewer.showError(context: context, error: state.error, callback: () {});
            }
            if (state is SignUpSuccess) {
              // Navigate to the next screen
            }
            if (state is SignUpDetailsSuccess) {}

          }, builder: (context, state) {
            if (state is SignUpLoading) {
              return const WaitingWidget();
            }
            return ListView(
              children: [
                screens[1],
              ],
            );
          }),
        ),
      ),
    );
  }
}
