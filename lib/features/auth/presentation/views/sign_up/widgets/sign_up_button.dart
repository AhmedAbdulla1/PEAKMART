
import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';

class SignUpButton extends StatefulWidget {
  const SignUpButton({super.key, this.onPressed});

  final void Function()? onPressed;
  @override
  State<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.simiBlue,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const FittedBox(
        child: Text(
          'Sign Up',
         
        ),
      ),
    );
  }
}
