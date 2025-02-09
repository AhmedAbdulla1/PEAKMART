import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      required this.stream,
      required this.onPressed,
      required this.text,
      this.width = double.infinity,
      this.height = AppSize.s55});

  final Stream<bool> stream;
  final VoidCallback onPressed;
  final String text;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: stream,
      builder: (context, snapshot) => SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: (snapshot.data ?? false) ? onPressed : null,
          child: Text(
            text,
            style: TextStyle(
              color: (snapshot.data ?? false)
                  ? Colors.white
                  : ColorManager.primary,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, this.onPressed, required this.title});

  final Function()? onPressed;

  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
      ),
    );
  }
}

class CustomElevatedButtonWithoutStream extends StatelessWidget {
  const CustomElevatedButtonWithoutStream(
      {super.key,
      required this.onPressed,
      required this.text,
      this.width = double.infinity,
      this.height = AppSize.s55});

  final VoidCallback? onPressed;
  final String text;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
        ),
      ),
    );
  }
}
