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
    if (customBuilder != null) return FieldType.custom;
    if (options != null) return FieldType.dropdown;
    if (keyboardType == TextInputType.datetime) return FieldType.date;
    if (keyboardType == TextInputType.phone) return FieldType.phone;
    if (allowMultipleImages) return FieldType.image; // Remove reference to 'type'
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
