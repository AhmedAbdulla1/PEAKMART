import 'package:flutter/material.dart';
import 'package:peakmart/features/auth/presentation/views/sign_up/widgets/sign_up_build_widgets.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _SignUpViewBodyState extends State<SignUpViewBody> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: const Padding(
        padding: EdgeInsets.fromLTRB(29, 0, 29, 30),
        child: SignUpBuildWidgets(),
      ),
    );
  }
}
