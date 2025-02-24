
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/errors/app_errors.dart';

import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/shared_widgets/buttons.dart';
import 'package:peakmart/features/auth/data/model/request/signup_for_bid_request.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/features/auth/presentation/state_mang/signup_for_bid/cubit.dart';
import 'widgets/dropdown_menu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _selectedCountry;
  bool isButtonActive = false;
  final List<String> countries = ['Egypt', 'Saudi Arabia'];

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_checkFormValidation);
    _addressController.addListener(_checkFormValidation);
    _govController.addListener(_checkFormValidation);
    _cityController.addListener(_checkFormValidation);
  }

  void _checkFormValidation() {
    bool allFieldsFilled = _usernameController.text.isNotEmpty &&
        _addressController.text.isNotEmpty &&
        _govController.text.isNotEmpty &&
        _cityController.text.isNotEmpty;

    if (isButtonActive != allFieldsFilled) {
      setState(() {
        isButtonActive = allFieldsFilled;
      });
    }
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // Show validation immediately
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
            validator: (value) => _validateRequired(value, "Display Name"),
          ),
          20.vGap,
          CustomDropdownMenu(
            onChanged: (selectedItem) {
              setState(() {
                _selectedCountry = selectedItem;
              });
            },
            items: countries,
            label: "Country",
            icon: const Icon(Icons.add_card_outlined),
            validator: (value) => _validateRequired(value, "Country"),
          ),
          20.vGap,
          CustomTextFormField(
            controller: _govController,
            labelText: "Gov",
            hintText: "Enter Gov",
            iconData: Icons.account_balance_outlined,
            inputType: TextInputType.text,
            validator: (value) => _validateRequired(value, "Gov"),
          ),
          20.vGap,
          CustomTextFormField(
            controller: _cityController,
            labelText: "City",
            hintText: "Enter Your City",
            iconData: Icons.location_city_outlined,
            inputType: TextInputType.text,
            validator: (value) => _validateRequired(value, "City"),
          ),
          20.vGap,
          CustomTextFormField(
            controller: _addressController,
            labelText: "Address",
            hintText: "Enter Your Address",
            iconData: Icons.edit_location_alt,
            inputType: TextInputType.streetAddress,
            validator: (value) => _validateRequired(value, "Address"),
          ),
          20.vGap,
          CustomDropdownMenu(
            onChanged: (selectedItem) {
              // Handle inland selection
            },
            items: const ['Inland', 'OutLand'],
            label: "",
            icon: const Icon(Icons.radar),
            validator: (value) => _validateRequired(value, "Inland"),
          ),
          20.vGap,
          CustomElevatedButtonWithoutStream(
            onPressed: () {
              if (_formKey.currentState!.validate()) {

                context.read<SignUpForBidCubit>().register(
                    registerRequest: RegisterAsSellerRequest(
                        displayName: _usernameController.text,
                        governmentName: _govController.text,
                        cityName: _cityController.text,
                        address: _addressController.text,
                        country: _selectedCountry!));
              } else {
                ErrorViewer.showError(
                    context: context,
                    error:
                        const CustomError(message: 'Enter All Required Fields'),
                    callback: () {});
              }
            },
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
    final  AppPreferences appPreferences =instance<AppPreferences>();
    try {
      String cookieString = appPreferences.getCookies().join(';');
      print('cookie string $cookieString');
      // Make the HTTP GET request
      final response = await http.get(url, headers: {"cookie": cookieString});

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