import 'dart:io';

void main() async {
  // Define the base directory for the form engine
  final baseDir = Directory('lib/core/form_engine');
  final widgetsDir = Directory('${baseDir.path}/widgets');

  // Check if directories exist
  if (await baseDir.exists()) {
    stdout.write('Directory ${baseDir.path} already exists. Overwrite? (y/n): ');
    final response = stdin.readLineSync();
    if (response?.toLowerCase() != 'y') {
      print('Aborted.');
      return;
    }
  }

  // Create directories
  await baseDir.create(recursive: true);
  await widgetsDir.create(recursive: true);

  // Define the content for each file
  final files = {
    '${baseDir.path}/form_field_config.dart': _formFieldConfigContent,
    '${baseDir.path}/form_controller.dart': _formControllerContent,
    '${baseDir.path}/dynamic_form.dart': _dynamicFormContent,
    '${baseDir.path}/form_field_builder.dart': _formFieldBuilderContent,
    '${widgetsDir.path}/phone_field.dart': _phoneFieldContent,
    '${widgetsDir.path}/country_picker_field.dart': _countryPickerFieldContent,
    '${widgetsDir.path}/image_picker_field.dart': _imagePickerFieldContent,
  };

  // Write each file
  for (var entry in files.entries) {
    final file = File(entry.key);
    await file.writeAsString(entry.value);
    print('Created: ${entry.key}');
  }

  print('\n✅ Form Engine generated successfully in lib/core/form_engine/');
  print('Please add the following dependencies to your pubspec.yaml:');
  print('- intl_phone_field: ^3.2.0');
  print('- country_picker: ^2.0.26');
  print('- image_picker: ^1.1.2');
}

// Content for form_field_config.dart
const _formFieldConfigContent = '''
// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

/// Enum defining the types of form fields supported by the form engine.
enum FieldType {
  text,
  date,
  dropdown,
  phone,
  country,
  image,
  location,
  custom,
}

/// Configuration for styling form fields.
class FieldStyleConfig {
  final Color? labelColor;
  final Color? borderColor;
  final TextStyle? textStyle;

  FieldStyleConfig({
    this.labelColor,
    this.borderColor,
    this.textStyle,
  });
}

/// Configuration class for a single form field.
class FieldConfig {
  final String name;
  final String label;
  final Map<String, String>? localeMap; // For localized labels
  final bool isRequired;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool withCountryCode;
  final bool allowMultipleImages;
  final List<String>? options;
  final String? hintText;
  final Map<String, String>? hintLocaleMap; // For localized hints
  final String? errorMessage; // Custom error message
  final String? Function(String?)? validator;
  final Widget Function(TextEditingController)? customBuilder;
  final FieldStyleConfig? styleConfig;

  FieldConfig({
    required this.name,
    required this.label,
    this.localeMap,
    this.isRequired = false,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.withCountryCode = false,
    this.allowMultipleImages = false,
    this.options,
    this.hintText,
    this.hintLocaleMap,
    this.errorMessage,
    this.validator,
    this.customBuilder,
    this.styleConfig,
  });

  /// Factory for creating a text field configuration.
  factory FieldConfig.text({
    required String name,
    required String label,
    Map<String, String>? localeMap,
    bool isRequired = false,
    String? hintText,
    Map<String, String>? hintLocaleMap,
    String? errorMessage,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    FieldStyleConfig? styleConfig,
  }) {
    return FieldConfig(
      name: name,
      label: label,
      localeMap: localeMap,
      isRequired: isRequired,
      keyboardType: TextInputType.text,
      hintText: hintText,
      hintLocaleMap: hintLocaleMap,
      errorMessage: errorMessage,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      validator: validator,
      styleConfig: styleConfig,
    );
  }

  /// Factory for creating a dropdown field configuration.
  factory FieldConfig.dropdown({
    required String name,
    required String label,
    required List<String> options,
    Map<String, String>? localeMap,
    bool isRequired = false,
    String? hintText,
    Map<String, String>? hintLocaleMap,
    String? errorMessage,
    String? Function(String?)? validator,
    FieldStyleConfig? styleConfig,
  }) {
    return FieldConfig(
      name: name,
      label: label,
      localeMap: localeMap,
      isRequired: isRequired,
      options: options,
      hintText: hintText,
      hintLocaleMap: hintLocaleMap,
      errorMessage: errorMessage,
      validator: validator,
      styleConfig: styleConfig,
    );
  }

  /// Factory for creating a date field configuration.
  factory FieldConfig.date({
    required String name,
    required String label,
    Map<String, String>? localeMap,
    bool isRequired = false,
    String? hintText,
    Map<String, String>? hintLocaleMap,
    String? errorMessage,
    String? Function(String?)? validator,
    FieldStyleConfig? styleConfig,
  }) {
    return FieldConfig(
      name: name,
      label: label,
      localeMap: localeMap,
      isRequired: isRequired,
      keyboardType: TextInputType.datetime,
      hintText: hintText,
      hintLocaleMap: hintLocaleMap,
      errorMessage: errorMessage,
      validator: validator,
      styleConfig: styleConfig,
    );
  }

  /// Factory for creating a phone field configuration.
  factory FieldConfig.phone({
    required String name,
    required String label,
    Map<String, String>? localeMap,
    bool isRequired = false,
    String? hintText,
    Map<String, String>? hintLocaleMap,
    String? errorMessage,
    bool withCountryCode = true,
    String? Function(String?)? validator,
    FieldStyleConfig? styleConfig,
  }) {
    return FieldConfig(
      name: name,
      label: label,
      localeMap: localeMap,
      isRequired: isRequired,
      keyboardType: TextInputType.phone,
      hintText: hintText,
      hintLocaleMap: hintLocaleMap,
      errorMessage: errorMessage,
      withCountryCode: withCountryCode,
      validator: validator,
      styleConfig: styleConfig,
    );
  }

  /// Factory for creating a country field configuration.
  factory FieldConfig.country({
    required String name,
    required String label,
    Map<String, String>? localeMap,
    bool isRequired = false,
    String? hintText,
    Map<String, String>? hintLocaleMap,
    String? errorMessage,
    String? Function(String?)? validator,
    FieldStyleConfig? styleConfig,
  }) {
    return FieldConfig(
      name: name,
      label: label,
      localeMap: localeMap,
      isRequired: isRequired,
      hintText: hintText,
      hintLocaleMap: hintLocaleMap,
      errorMessage: errorMessage,
      validator: validator,
      styleConfig: styleConfig,
    );
  }

  /// Factory for creating an image field configuration.
  factory FieldConfig.image({
    required String name,
    required String label,
    Map<String, String>? localeMap,
    bool isRequired = false,
    bool allowMultipleImages = false,
    String? errorMessage,
    String? Function(String?)? validator,
    FieldStyleConfig? styleConfig,
  }) {
    return FieldConfig(
      name: name,
      label: label,
      localeMap: localeMap,
      isRequired: isRequired,
      allowMultipleImages: allowMultipleImages,
      errorMessage: errorMessage,
      validator: validator,
      styleConfig: styleConfig,
    );
  }

  /// Factory for creating a custom field configuration.
  factory FieldConfig.custom({
    required String name,
    required String label,
    Map<String, String>? localeMap,
    required Widget Function(TextEditingController) customBuilder,
    bool isRequired = false,
    String? hintText,
    Map<String, String>? hintLocaleMap,
    String? errorMessage,
    String? Function(String?)? validator,
    FieldStyleConfig? styleConfig,
  }) {
    return FieldConfig(
      name: name,
      label: label,
      localeMap: localeMap,
      isRequired: isRequired,
      hintText: hintText,
      hintLocaleMap: hintLocaleMap,
      errorMessage: errorMessage,
      validator: validator,
      customBuilder: customBuilder,
      styleConfig: styleConfig,
    );
  }

  /// Determines the field type based on configuration.
  FieldType get type {
    if (options != null) return FieldType.dropdown;
    if (keyboardType == TextInputType.datetime) return FieldType.date;
    if (keyboardType == TextInputType.phone) return FieldType.phone;
    if (allowMultipleImages || type == FieldType.image) return FieldType.image;
    if (customBuilder != null) return FieldType.custom;
    return FieldType.text;
  }

  /// Retrieves localized label based on the provided locale.
  String getLocalizedLabel(String locale) {
    return localeMap?[locale] ?? label;
  }

  /// Retrieves localized hint text based on the provided locale.
  String? getLocalizedHint(String locale) {
    return hintLocaleMap?[locale] ?? hintText;
  }
}
''';

// Content for form_controller.dart
const _formControllerContent = '''
/// Controller class for managing form state and actions.
class FormController {
  // Placeholder for future form management logic (submit, clear, etc.)
  // This will be expanded later to handle form submission, clearing fields, etc.
}
''';

// Content for dynamic_form.dart
const _dynamicFormContent = '''
import 'package:flutter/material.dart';
import 'form_field_config.dart';
import 'form_controller.dart';
import 'form_field_builder.dart';

/// A dynamic form widget that renders fields based on provided configurations.
class DynamicForm extends StatefulWidget {
  final List<FieldConfig> fields;
  final void Function(Map<String, dynamic>) onSubmit;
  final FormController controller;
  final String locale;

  const DynamicForm({
    super.key,
    required this.fields,
    required this.onSubmit,
    required this.controller,
    this.locale = 'en',
  });

  @override
  State<DynamicForm> createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, dynamic> _extraValues = {};
  final Map<String, bool> _showErrors = {};
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    // Lazy initialization of controllers
    for (var field in widget.fields) {
      _showErrors[field.name] = false;
    }
  }

  TextEditingController _getController(String name) {
    return _controllers.putIfAbsent(name, () => TextEditingController());
  }

  void _handleSubmit() {
    setState(() {
      _submitted = true;
      for (var field in widget.fields) {
        _showErrors[field.name] = true;
      }
    });

    if (_formKey.currentState!.validate()) {
      final formData = <String, dynamic>{};
      for (var field in widget.fields) {
        formData[field.name] = _extraValues[field.name] ?? _getController(field.name).text;
      }
      widget.onSubmit(formData);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...widget.fields.map((field) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: buildFormField(
                  context,
                  field,
                  _getController(field.name),
                  _showErrors[field.name]!,
                  _submitted,
                  (value) => setState(() {
                    _extraValues[field.name] = value;
                  }),
                  widget.locale,
                ),
              )),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _handleSubmit,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
''';

// Content for form_field_builder.dart
const _formFieldBuilderContent = '''
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
''';

// Content for widgets/phone_field.dart
const _phoneFieldContent = '''
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
''';

// Content for widgets/country_picker_field.dart
const _countryPickerFieldContent = '''
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
''';

// Content for widgets/image_picker_field.dart
const _imagePickerFieldContent = '''
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../form_field_config.dart';

/// An image picker field supporting single or multiple image selection.
class ImagePickerField extends StatelessWidget {
  final FieldConfig config;
  final bool showError;
  final bool submitted;
  final void Function(dynamic) onChanged;

  const ImagePickerField({
    super.key,
    required this.config,
    required this.showError,
    required this.submitted,
    required this.onChanged,
  });

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    if (config.allowMultipleImages) {
      final images = await picker.pickMultiImage();
      if (images.isNotEmpty) {
        onChanged(images.map((img) => File(img.path)).toList());
      }
    } else {
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        onChanged(File(image.path));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          config.getLocalizedLabel('en'), // Default to 'en' for now
          style: config.styleConfig?.textStyle ?? Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => _pickImage(context),
          child: Text(config.allowMultipleImages ? 'Pick Images' : 'Pick Image'),
        ),
        if (showError && submitted && config.validator != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              config.validator!('') ?? config.errorMessage ?? '',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
      ],
    );
  }
}
''';