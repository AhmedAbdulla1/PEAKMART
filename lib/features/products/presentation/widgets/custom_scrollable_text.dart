import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';

class CustomScrollableText extends StatelessWidget {
  const CustomScrollableText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s16),
        Expanded(
          child: Container(
              padding: const EdgeInsets.all(AppPadding.p12),
              decoration: BoxDecoration(
                color: ColorManager.darkGrey.withOpacity(.1),
                borderRadius: BorderRadius.circular(AppSize.s12),
              ),
              child:  Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Text(
                    text,
                    textAlign: TextAlign.start,
                    style: getRegularStyle(
                        fontSize: FontSize.s17,
                        color: ColorManager.black.withOpacity(.8)),
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
