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
