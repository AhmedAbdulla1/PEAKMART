import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/shared_widgets/buttons.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_text_form_field.dart';

import 'widgets/dropdown_menu.dart';

class MainInfo extends StatefulWidget {
  const MainInfo({super.key});

  @override
  State<MainInfo> createState() => _MainInfoState();
}

class _MainInfoState extends State<MainInfo> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _countryController = TextEditingController();

  final TextEditingController _govController = TextEditingController();

  final TextEditingController _cityController = TextEditingController();

  final TextEditingController _inlandController = TextEditingController();
  String? _selectedCountry;
  final List<String> countries = ['Egypt', 'Saudi Arabia',];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextFormField(
          controller: _usernameController,
          labelText: "Display Name",
          hintText: "Enter your display name",
          iconData: Icons.person_2_outlined,
          inputType: TextInputType.name,
        ),
        20.vGap,
        CustomDropdownMenu(
          onChanged: (selectedItem){},
          items: ['Egypt', 'Saudi Arabia',],
          label: "Country",
          icon: Icon(Icons.add_card_outlined),
        ),
        20.vGap,
        CustomTextFormField(
          controller: _govController,
          labelText: "Gov",
          hintText: "Enter Gov",
          iconData: Icons.account_balance_outlined,
          inputType: TextInputType.text,
        ),
        20.vGap,
        CustomTextFormField(
          controller: _cityController,
          labelText: "City",
          hintText: "Enter Your City",
          iconData: Icons.location_city_outlined,
          inputType: TextInputType.text,
        ),
        20.vGap,
        CustomTextFormField(
          controller: _addressController,
          labelText: "Address",
          hintText: "Enter Your Address",
          iconData: Icons.edit_location_alt,
          inputType: TextInputType.streetAddress,
        ),
        20.vGap,
        CustomDropdownMenu(
          onChanged: (selectedItem){},
          items: ['Egypt', 'Saudi Arabia',],
          label: "Inland",
          icon: Icon(Icons.radar),
        ),
      ],
    );
  }
}
