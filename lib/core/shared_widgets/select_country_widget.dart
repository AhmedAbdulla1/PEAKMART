import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/shared_widgets/custom_text_field.dart';
import 'package:peakmart/features/profile/presentation/state_m/profile/cubit.dart';

class SelectCountryWidget extends StatefulWidget {
  const SelectCountryWidget({super.key, required this.controller});
  final TextEditingController controller;
  @override
  State<SelectCountryWidget> createState() => _SelectCountryWidgetState();
}

class _SelectCountryWidgetState extends State<SelectCountryWidget> {
  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode:
          false, // optional. Shows phone code before the country name.
      onSelect: (Country country) {
        log('Selected country: ${country.name}');
        setState(() {
          widget.controller.text = country.name;
        });
        context.read<ProfileCubit>().updateCountry(country.name);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openCountryPicker,
      child: AbsorbPointer(
        child: CustomTextField(
          prefixIcon: Icons.public,
          suffixIcon: Icons.arrow_drop_down_outlined,
          label: "Country",
          controller: widget.controller,
          onChanged: (_) {}, // No need to update manually
        ),
      ),
    );
  }
}
