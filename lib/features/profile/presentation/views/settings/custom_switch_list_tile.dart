import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';

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
      shadowColor: ColorManager.white,
      elevation: 1,
      child: SwitchListTile(
          splashRadius: 30,
          secondary: Icon(leadingIcon),
          title: Text(
            title,
            style: TextStyle(color: ColorManager.black, fontSize: 20),
          ),
          value: isActive,
          onChanged: onNotificationsChanged),
    );
  }
}
