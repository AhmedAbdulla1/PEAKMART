import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';

class CustomSwitchListTile extends StatelessWidget {
  const CustomSwitchListTile({
    super.key,
    required this.isActive,
    this.onNotificationsChanged,
    required this.leadingIcon,
    required this.title,
  });
  final String title;
  final IconData leadingIcon;
  final bool isActive;
  final void Function(bool)? onNotificationsChanged;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colorScheme.surface,
      shadowColor: context.colorScheme.surface,
      elevation: 1,
      child: SwitchListTile(
          activeColor: ColorManager.primary,
          splashRadius: 30,
          secondary: Icon(leadingIcon),
          title: Text(
            title,
            style: getMediumStyle(fontSize: FontSize.s20),
          ),
          value: isActive,
          onChanged: onNotificationsChanged),
    );
  }
}
