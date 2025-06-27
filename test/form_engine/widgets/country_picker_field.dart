import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import '../form_field_config.dart';

/// A country selection field using country_picker.
class CountryPickerField extends StatelessWidget {
  final FieldConfig config;
  final TextEditingController controller;
  final bool showError;
  final bool submitted;
  final void Function(Map<String, String>) onChanged;
  final String locale;

  const CountryPickerField({
    super.key,
    required this.config,
    required this.controller,
    required this.showError,
    required this.submitted,
    required this.onChanged,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: config.getLocalizedLabel(locale),
        hintText: config.getLocalizedHint(locale),
        errorText: showError && submitted && config.validator != null
            ? config.validator!(controller.text) ?? config.errorMessage
            : null,
        labelStyle: config.styleConfig?.textStyle,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: config.styleConfig?.borderColor ?? Theme.of(context).primaryColor,
          ),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.arrow_drop_down),
          onPressed: () {
            showCountryPicker(
              context: context,
              onSelect: (Country country) {
                controller.text = country.name;
                onChanged({
                  'name': country.name,
                  'code': country.countryCode,
                });
              },
            );
          },
        ),
      ),
      validator: config.validator,
    );
  }
}
