import 'package:Bid_Mart/core/shared_widgets/custom_text_field.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class SelectCountryWidget extends StatefulWidget {
  const SelectCountryWidget({
    super.key,
    required this.onSelect,
    this.initialCountry,
    this.controller,
  });

  final void Function(Country) onSelect;
  final Country? initialCountry;
  final TextEditingController? controller;

  @override
  State<SelectCountryWidget> createState() => _SelectCountryWidgetState();
}

class _SelectCountryWidgetState extends State<SelectCountryWidget> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();

    if (widget.initialCountry != null) {
      controller.text = widget.initialCountry!.name;
    }
  }

  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      useSafeArea: true,
      showPhoneCode: false,
      countryListTheme: const CountryListThemeData(
        backgroundColor: Color(0xFF9E9E9E),
      ),
      onSelect: (country) {
        setState(() {
          controller.text = country.name;
        });
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
          onChanged: (_) {},
        ),
      ),
    );
  }
}
