import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatelessWidget {
  CustomDropdownMenu(
      {super.key,
      required this.items,
      this.validator,
      required this.label,
      required this.onChanged,
      required this.icon});

  String? _selectedCountry;
  final List<String> items;
  final String label;
  final Function(String?) onChanged;
  final Widget? icon;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      iconEnabledColor:
          context.isDarkMode ? ColorManager.white : ColorManager.black,
      iconDisabledColor: ColorManager.grey,
      onTap: () {},
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      value: label.isEmpty ? items[0] : _selectedCountry,
      decoration: InputDecoration(
        labelText: label,
        hintText: label,
        hintStyle: getRegularStyle(
          color: context.isDarkMode ? ColorManager.red : Colors.red,
          fontSize: FontSize.s14,
        ),
        labelStyle: getRegularStyle(
          color: context.isDarkMode ? ColorManager.grey : ColorManager.darkGrey,
          fontSize: FontSize.s14,
        ),
        prefixIcon: icon,
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        _selectedCountry = newValue;
        onChanged(newValue);
      },
    );
  }
}
