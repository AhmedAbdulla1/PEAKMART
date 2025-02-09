import 'package:flutter/material.dart';
import 'package:timer_button/timer_button.dart';

class CustomDropdownMenu extends StatelessWidget {
  CustomDropdownMenu({super.key, required this.items, required this.label, required this.onChanged,required this.icon});

  String? _selectedCountry;
  final List<String> items;
  final String label;
  final Function(String?)  onChanged;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedCountry,
      decoration: InputDecoration(labelText: label,
        prefixIcon: icon,
        suffixIcon:const Icon(Icons.keyboard_arrow_down, size: 30,),
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
