import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/app/app.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/core/shared_widgets/buttons.dart';
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
    return BlocProvider(
      create: (context) => _signUpForBidCubit,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
              left: AppPadding.p20,
              right: AppPadding.p20,
              top: 100,
              bottom: AppPadding.p65),
          child: BlocConsumer(
            listener: (context, state) {
              if (state is SignUpFailure) {
                index=0 ;
                // Show error message
              }
              if (state is SignUpSuccess) {
                // Navigate to the next screen
              }
              if (state is SignUpDetailsLoading) {
                index = 1;
              }
            },
            builder: (context, state) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign up for bids",
                  style: getBoldStyle(
                      fontSize: AppSize.s32, color: ColorManager.black),
                ),
                const Spacer(),
                screens[index],
                const Spacer(),
                Visibility(
                  visible: index == 1,
                  child: CustomElevatedButtonWithoutStream(
                      onPressed: () {
                          _signUpForBidCubit.back();
                      }, text: "Back"),
                ),
                CustomElevatedButtonWithoutStream(
                  onPressed: () {
                    _signUpForBidCubit.moveToDetails();
                    // final user = User(
                    //   username: _usernameController.text,
                    //   email: _emailController.text,
                    //   phoneNumber: _phoneController.text,
                    //   password: _passwordController.text,
                    //   country: _countryController.text,
                    //   gov: _govController.text,
                    //   city: _cityController.text,
                    //   inland: _inlandController.text,
                    // );
                    // context.read<SignUpForBidCubit>().add(SignUpSubmitted(user));
                  },
                  text: 'Continue',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
