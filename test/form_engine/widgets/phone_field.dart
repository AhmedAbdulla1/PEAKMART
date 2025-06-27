import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../form_field_config.dart';

/// A phone number input field with country code selection.
class PhoneField extends StatelessWidget {
  final FieldConfig config;
  final TextEditingController controller;
  final bool showError;
  final bool submitted;
  final void Function(String) onChanged;
  final String locale;

  const PhoneField({
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
    return IntlPhoneField(
      controller: controller,
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
      ),
      initialCountryCode: 'US',
      onChanged: (phone) {
        final completeNumber = phone.completeNumber;
        controller.text = completeNumber;
        onChanged(completeNumber);
      },
    );
  }
}
