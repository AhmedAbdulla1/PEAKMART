import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';

class BuildTextBodyWidget extends StatelessWidget {
  const BuildTextBodyWidget({super.key, required this.body});
  final String body;
  @override
  Widget build(BuildContext context) {
    return Text(
      body,
      // textAlign: TextAlign.center,
      style: getRegularStyle(fontSize: FontSize.s17),
    );
  }
}
