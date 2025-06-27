import 'package:flutter/material.dart';
import 'form_field_config.dart';
import 'widgets/phone_field.dart';
import 'widgets/country_picker_field.dart';
import 'widgets/image_picker_field.dart';

/// Builds the appropriate form field widget based on the field configuration.
Widget buildFormField(
  BuildContext context,
  FieldConfig field,
  TextEditingController controller,
  bool showError,
  bool submitted,
  void Function(dynamic) onExtraValue,
  String locale,
) {
  final decoration = InputDecoration(
    labelText: field.getLocalizedLabel(locale),
    hintText: field.getLocalizedHint(locale),
    prefixIcon: field.prefixIcon,
    suffixIcon: field.suffixIcon,
    labelStyle: field.styleConfig?.textStyle,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: field.styleConfig?.borderColor ?? Theme.of(context).primaryColor,
      ),
    ),
    errorText: showError && submitted && field.validator != null
        ? field.validator!(controller.text) ?? field.errorMessage
        : null,
  );

  switch (field.type) {
    case FieldType.text:
      return TextFormField(
        controller: controller,
        decoration: decoration,
        keyboardType: field.keyboardType,
        obscureText: field.obscureText,
        validator: field.validator,
      );

    case FieldType.date:
      return TextFormField(
        controller: controller,
        decoration: decoration.copyWith(
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
              if (date != null) {
                controller.text = date.toString().split(' ')[0];
              }
            },
          ),
        ),
        keyboardType: TextInputType.datetime,
        validator: field.validator,
      );

    case FieldType.dropdown:
      return DropdownButtonFormField<String>(
        decoration: decoration,
        value: controller.text.isNotEmpty ? controller.text : null,
        items: field.options!.map((option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            controller.text = value;
          }
        },
        validator: field.validator,
      );

    case FieldType.phone:
      return PhoneField(
        config: field,
        controller: controller,
        showError: showError,
        submitted: submitted,
        onChanged: (value) {
          controller.text = value;
          onExtraValue(value);
        },
        locale: locale,
      );

    case FieldType.country:
      return CountryPickerField(
        config: field,
        controller: controller,
        showError: showError,
        submitted: submitted,
        onChanged: (value) {
          controller.text = value['name'] ?? '';
          onExtraValue(value['code']);
        },
        locale: locale,
      );

    case FieldType.image:
      return ImagePickerField(
        config: field,
        showError: showError,
        submitted: submitted,
        onChanged: (value) {
          controller.text = value.toString();
          onExtraValue(value);
        },
      );

    case FieldType.custom:
      return field.customBuilder!(controller);

    default:
      return const SizedBox.shrink();
  }
}
