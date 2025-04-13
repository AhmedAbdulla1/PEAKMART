import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/shared_widgets/buttons.dart';
import 'package:peakmart/core/shared_widgets/image_picker.dart';
import 'package:peakmart/features/auth/data/model/request/seller_info_request.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_text_form_field.dart';
import 'package:peakmart/features/auth/presentation/state_mang/signup_for_bid/cubit.dart';
import 'package:peakmart/features/auth/presentation/views/signup_for_bid/widgets/dropdown_menu.dart';

class AdditionalDetails extends StatefulWidget {
  const AdditionalDetails({super.key});

  @override
  State<AdditionalDetails> createState() => _AdditionalDetailsState();
}

class _AdditionalDetailsState extends State<AdditionalDetails> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _ssnController = TextEditingController();
  final TextEditingController _ibanController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  File? _idImage;
  File? _ibanImage;
  bool _isIdImageSelected = false;
  bool _isIbanImageSelected = false;

  // Track touched state for each field
  final Map<String, bool> _fieldTouchedState = {
    'fullName': false,
    'ssn': false,
    'bankName': false,
    'iban': false,
    'idImage': false,
    'ibanImage': false,
  };

  // Check if all fields are valid
  bool get _isFormValid {
    bool allFieldsTouched =
        _fieldTouchedState.values.every((touched) => touched);
    return _validateFullName(_fullNameController.text) == null &&
        _validateSSN(_ssnController.text) == null &&
        _validateBankName(_bankName) == null &&
        _validateIBAN(_ibanController.text) == null &&
        _validateImage(_isIdImageSelected, 'id') == null &&
        _validateImage(_isIbanImageSelected, 'iban') == null &&
        allFieldsTouched;
  }

  String? _bankName;

  @override
  void initState() {
    super.initState();
    // Add listeners to controllers to update touched state
    _fullNameController.addListener(() => _updateTouchedState('fullName'));
    _ssnController.addListener(() => _updateTouchedState('ssn'));
    _ibanController.addListener(() => _updateTouchedState('iban'));
  }

  // Update touched state for a field
  void _updateTouchedState(String fieldName) {
    setState(() {
      _fieldTouchedState[fieldName] = true;
    });
  }

  // Mark all fields as touched
  void _markAllFieldsAsTouched() {
    setState(() {
      _fieldTouchedState.updateAll((key, value) => true);
    });
  }

  // Validators
  String? _validateFullName(String? value) {
    if (!_fieldTouchedState['fullName']!) {
      return null; // Don't show error if field hasn't been touched
    }
    if (value == null || value.trim().length < 7) {
      return 'Full name must be at least 7 characters.';
    }
    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
      return 'Only letters and spaces are allowed.';
    }
    return null;
  }

  String? _validateSSN(String? value) {
    if (!_fieldTouchedState['ssn']!) {
      return null; // Don't show error if field hasn't been touched
    }
    if (value == null || value.length < 8 || value.length > 16) {
      return 'Enter a valid National ID (8-16 digits).';
    }
    if (!RegExp(r"^\d+$").hasMatch(value)) {
      return 'National ID should contain numbers only.';
    }
    return null;
  }

  String? _validateBankName(String? value) {
    if (!_fieldTouchedState['bankName']!) {
      return null; // Don't show error if field hasn't been touched
    }
    if (value == null || value.isEmpty) {
      return 'Bank Name is required';
    }
    return null;
  }

  String? _validateIBAN(String? value) {
    if (!_fieldTouchedState['iban']!) {
      return null; // Don't show error if field hasn't been touched
    }
    if (value == null || value.length < 16) {
      return 'Enter a valid IBAN (16 characters).';
    }
    if (!RegExp(r"^[A-Za-z0-9]+$").hasMatch(value)) {
      return 'IBAN should contain only letters and numbers.';
    }
    return null;
  }

  String? _validateImage(bool isImageSelected, String fieldName) {
    if (!_fieldTouchedState['${fieldName.toLowerCase()}Image']!) {
      return null; // Don't show error if field hasn't been touched
    }
    if (!isImageSelected) {
      return 'Please upload your $fieldName';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // National ID Info Section
            Text(
              'National ID Info :',
              style: getMediumStyle(
                  fontSize: FontSize.s16, color: ColorManager.black),
            ),
            20.vGap,
            CustomTextFormField(
              labelText: 'Full Id Name',
              hintText: 'Enter your full name',
              inputType: TextInputType.name,
              controller: _fullNameController,
              iconData: Icons.person,
              validator: _validateFullName,
              inputFormatter: [
                FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s]")),
              ],
              onChanged: (_) => _updateTouchedState('fullName'),
            ),
            20.vGap,
            CustomTextFormField(
              labelText: 'SSN',
              hintText: 'Enter your SSN',
              validator: _validateSSN,
              inputType: TextInputType.number,
              controller: _ssnController,
              inputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
              ],
              iconData: Icons.credit_card,
              onChanged: (_) => _updateTouchedState('ssn'),
            ),
            20.vGap,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImagePickerWidget(
                  onImageSelected: (File? image) {
                    setState(() {
                      _idImage = image;
                      _isIdImageSelected = image != null;
                      _fieldTouchedState['idImage'] = true;
                    });
                  },
                  title: 'Upload your ID Photo',
                ),
                if (!_isIdImageSelected && _fieldTouchedState['idImage']!)
                  const Text(
                    'Please upload your ID Photo',
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
              ],
            ),
            20.vGap,

            // Banking Info Section
            Text(
              'Banking Info :',
              style: getMediumStyle(
                  fontSize: FontSize.s16, color: ColorManager.black),
            ),
            20.vGap,
            CustomDropdownMenu(
              icon: Icon(
                Icons.account_balance,
                size: 30,
                color: ColorManager.textPrimary,
              ),
              label: 'Bank Name',
              items: const [
                "Bank masr1",
                "Bank masr2",
                "Bank elahly 1",
                "Bank elahly 2",
              ],
             
              validator: _validateBankName,
              onChanged: (value) {
                setState(() {
                  _bankName = value;
                  _fieldTouchedState['bankName'] = true;
                });
              },
            ),
            20.vGap,
            CustomTextFormField(
              controller: _ibanController,
              hintText: "Enter your IBAN",
              labelText: 'IBAN',
              validator: _validateIBAN,
              iconData: Icons.edit_document,
              inputType: TextInputType.number,
              inputFormatter: [
                // FilteringTextInputFormatter.allow(RegExp(r"[A-Za-z0-9]")),
                LengthLimitingTextInputFormatter(16),
              ],
              onChanged: (_) => _updateTouchedState('iban'),
            ),
            20.vGap,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImagePickerWidget(
                  onImageSelected: (File? image) {
                    setState(() {
                      _ibanImage = image;
                      _isIbanImageSelected = image != null;
                      _fieldTouchedState['ibanImage'] = true;
                    });
                  },
                  title: 'Upload your IBAN Photo',
                ),
                if (!_isIbanImageSelected && _fieldTouchedState['ibanImage']!)
                  const Text(
                    'Please upload your IBAN Photo',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
              ],
            ),
            20.vGap,

            // Continue Button
            CustomElevatedButtonWithoutStream(
              onPressed: _isFormValid
                  ? () {
                      _markAllFieldsAsTouched(); // Mark all fields as touched
                      if (_formKey.currentState!.validate()) {
                        context.read<SignUpForBidCubit>().sellerInfo(
                              sellerInfo: SellerInfoRequest(
                                fullName: _fullNameController.text,
                                idNumber: _ssnController.text,
                                idImage: _idImage!,
                                iban: _ibanController.text,
                                ibanImage: _ibanImage!,
                              ),
                            );
                      }
                    }
                  : null, // Disable button if form is not valid
              text: 'Continue',
            ),
          ],
        ),
      ),
    );
  }
}
