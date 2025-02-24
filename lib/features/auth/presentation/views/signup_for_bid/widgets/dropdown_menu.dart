import 'package:flutter/material.dart';
import 'package:timer_button/timer_button.dart';

class CustomDropdownMenu extends StatelessWidget {
  CustomDropdownMenu({super.key, required this.items,this.validator,  required this.label, required this.onChanged,required this.icon});

  String? _selectedCountry;
  final List<String> items;
  final String label;
  final Function(String?)  onChanged;
  final Widget? icon;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      onTap: (){
        print("onTap");
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator ,
      value: _selectedCountry??items[0],
      decoration: InputDecoration(labelText: label,
        hintText: label,
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
