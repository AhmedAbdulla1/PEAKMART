import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/resources/assets_manager.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:peakmart/core/shared_widgets/buttons.dart';
import 'package:peakmart/features/auth/data/model/request/signup_for_bid_request.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_text_form_field.dart';
import 'package:peakmart/features/auth/presentation/state_mang/signup_for_bid/cubit.dart';

import 'widgets/dropdown_menu.dart';

class MainInfo extends StatefulWidget {
  const MainInfo({super.key});

  @override
  State<MainInfo> createState() => _MainInfoState();
}

class _MainInfoState extends State<MainInfo> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _govController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _inlandController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _selectedCountry;
  final List<String> countries = ['Egypt', 'Saudi Arabia'];

  // Track touched state for each field
  final Map<String, bool> _fieldTouchedState = {
    'username': false,
    'country': false,
    'gov': false,
    'city': false,
    'address': false,
    // 'inland': false,
  };

  // Check if all fields are valid
  bool get _isFormValid {
    // Check if all fields are touched
    bool allFieldsTouched =
        _fieldTouchedState.values.every((touched) => touched);

    // Check if all fields are valid
    bool allFieldsValid =
        _validateDisplayName(_usernameController.text) == null &&
            _validateCountry(_selectedCountry) == null &&
            _validateGov(_govController.text) == null &&
            _validateCity(_cityController.text) == null &&
            _validateAddress(_addressController.text) == null;

    // Return true only if all fields are touched and valid
    return allFieldsTouched && allFieldsValid;
  }

  @override
  void initState() {
    super.initState();
    // Add listeners to controllers to update touched state
    _fieldTouchedState['inland'] = true; // Mark as touched
    _usernameController.addListener(() => _updateTouchedState('username'));
    _govController.addListener(() => _updateTouchedState('gov'));
    _cityController.addListener(() => _updateTouchedState('city'));
    _addressController.addListener(() => _updateTouchedState('address'));
    // _inlandController.addListener(() => _updateTouchedState('inland'));
    // _validateInland(null);
  }

  // Update touched state for a field
  void _updateTouchedState(String fieldName) {
    setState(() {
      _fieldTouchedState[fieldName] = true;
    });
  }

  // Validators
  String? _validateDisplayName(String? value) {
    if (!_fieldTouchedState['username']!) {
      return null; // Don't show error if field hasn't been touched
    }
    if (value == null || value.isEmpty) {
      return 'Display Name is required';
    }
    if (value.length < 3) {
      return 'Display Name must be at least 3 characters';
    }
    return null;
  }

  String? _validateCountry(String? value) {
    if (!_fieldTouchedState['country']!) {
      return null; // Don't show error if field hasn't been touched
    }
    if (value == null || value.isEmpty) {
      return 'Country is required';
    }
    return null;
  }

  String? _validateGov(String? value) {
    if (!_fieldTouchedState['gov']!) {
      return null; // Don't show error if field hasn't been touched
    }
    if (value == null || value.isEmpty) {
      return 'Gov is required';
    }
    return null;
  }

  String? _validateCity(String? value) {
    if (!_fieldTouchedState['city']!) {
      return null; // Don't show error if field hasn't been touched
    }
    if (value == null || value.isEmpty) {
      return 'City is required';
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (!_fieldTouchedState['address']!) {
      return null; // Don't show error if field hasn't been touched
    }
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    return null;
  }

  String? _validateInland(String? value) {
    if (!_fieldTouchedState['inland']!) {
      return null; // Don't show error if field hasn't been touched
    }
    if (value == null || value.isEmpty) {
      return 'Field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          100.h.vGap,
          CustomTextFormField(
            controller: _usernameController,
            labelText: "Display Name",
            hintText: "Enter your display name",
            iconData: Icons.person_2_outlined,
            inputType: TextInputType.name,
            validator: _validateDisplayName,
            inputFormatter: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z\s]'),
              )
            ],
            onChanged: (_) => _updateTouchedState('username'),
          ),
          20.vGap,
          CustomDropdownMenu(
            onChanged: (selectedItem) {
              setState(() {
                _selectedCountry = selectedItem;
                _fieldTouchedState['country'] = true; // Mark as touched
              });
            },
            items: countries,
            label: "",
            icon: Image.asset(
              IconsAssets.countryIcon,
              color: context.isDarkMode
                  ? ColorManager.greyColor
                  : ColorManager.darkGrey,
            ),
            validator: _validateCountry,
          ),
          20.vGap,
          CustomTextFormField(
            controller: _govController,
            labelText: "Gov",
            hintText: "Enter Gov",
            inputFormatter: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z\s]'),
              )
            ],
            iconData: Icons.account_balance_outlined,
            inputType: TextInputType.text,
            validator: _validateGov,
            onChanged: (_) => _updateTouchedState('gov'),
          ),
          20.vGap,
          CustomTextFormField(
            controller: _cityController,
            labelText: "City",
            hintText: "Enter Your City",
            iconData: Icons.location_city_outlined,
            inputType: TextInputType.text,
            inputFormatter: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z\s]'),
              )
            ],
            validator: _validateCity,
            onChanged: (_) => _updateTouchedState('city'),
          ),
          20.vGap,
          CustomTextFormField(
            controller: _addressController,
            labelText: "Address",
            hintText: "Enter Your Address",
            iconData: Icons.edit_location_alt,
            inputType: TextInputType.streetAddress,
            validator: _validateAddress,
            onChanged: (_) => _updateTouchedState('address'),
          ),
          20.vGap,
          CustomDropdownMenu(
            onChanged: (selectedItem) {
              setState(() {
                _inlandController.text = selectedItem!; // Update the controller
              });
            },
            items: const ['Inland', 'OutLand'],
            label: "",
            icon: const Icon(Icons.radar),
            // validator: _validateInland,
          ),
          20.vGap,
          CustomElevatedButtonWithoutStream(
            onPressed: _isFormValid
                ? () {
                    context.read<SignUpForBidCubit>().register(
                        registerRequest: RegisterAsSellerRequest(
                            displayName: _usernameController.text,
                            governmentName: _govController.text,
                            cityName: _cityController.text,
                            address: _addressController.text,
                            country: _selectedCountry!));
                  }
                : null, // Disable button if form is not valid
            text: 'Continue',
          ),
        ],
      ),
    );
  }
}

class CookieService {
  // Base URL of the API
  static const String _baseUrl = 'https://hk.herova.net';

  // Function to fetch cookies
  static Future<dynamic> getCookies() async {
    final url = Uri.parse('$_baseUrl/login_API/cookies.php');
    final AppPreferences appPreferences = instance<AppPreferences>();
    try {
      String cookieString = appPreferences.getCookies().join(';');
      print('cookie string $cookieString');
      // Make the HTTP GET request
      final response = await http.get(url, headers: {"cookie": '    hhgg'});

      if (response.statusCode == 200) {
        // Parse the JSON response
        final cookies = jsonDecode(response.body);
        print('cookies ${response.body}');
        return cookies;
      } else {
        // Handle non-200 status codes
        throw Exception('Failed to load cookies: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors
      throw Exception('Error fetching cookies: $e');
    }
  }
}
