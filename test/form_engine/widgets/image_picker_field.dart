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
