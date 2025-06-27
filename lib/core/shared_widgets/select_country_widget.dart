import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:peakmart/core/shared_widgets/custom_text_field.dart';

class SelectCountryWidget extends StatefulWidget {
  const SelectCountryWidget({super.key, required this.onSelect});

  final void Function(Country) onSelect;

  @override
  State<SelectCountryWidget> createState() => _SelectCountryWidgetState();
}

class _SelectCountryWidgetState extends State<SelectCountryWidget> {
  final TextEditingController controller = TextEditingController();

  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      useSafeArea: true,
      showPhoneCode: false,
      // optional. Shows phone code before the country name.
      onSelect: (country) {
        controller.text = country.name;
        widget.onSelect(country);
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
          controller: controller,
          onChanged: (_) {}, // No need to update manually
        ),
      ),
    );
  }
}
