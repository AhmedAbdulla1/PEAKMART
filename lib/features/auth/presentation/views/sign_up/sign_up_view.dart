import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/features/auth/presentation/state_mang/register_cubit.dart/register_cubit.dart';
import 'package:peakmart/features/auth/presentation/views/sign_up/widgets/sign_up_view_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  static const String routeName = '/sign_up_view';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: BlocProvider(
            create: (context) => RegisterCubit(),
            child: const SignUpViewBody(),
          ),
        ),
      ),
    );
  }
}
