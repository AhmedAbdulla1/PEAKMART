import 'dart:io';

import 'package:flutter/material.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/shared_widgets/buttons.dart';
import 'package:peakmart/core/shared_widgets/image_picker.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_text_form_field.dart';
import 'package:peakmart/features/auth/presentation/views/signup_for_bid/widgets/dropdown_menu.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:peakmart/features/main/main_view.dart';

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

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() &&
        _idImage != null &&
        _ibanImage != null) {
      final url =
          Uri.parse('https://hk.herova.net/bids/bid_owner_rig_info.php');

      var request = http.MultipartRequest('POST', url);

      // Add text fields
      request.fields['full_name'] = _fullNameController.text;
      request.fields['id_number'] = _ssnController.text;
      request.fields['iban'] = _ibanController.text;

      // Add image files
      request.files
          .add(await http.MultipartFile.fromPath('id_img', _idImage!.path));
      request.files
          .add(await http.MultipartFile.fromPath('iban_img', _ibanImage!.path));

      try {
        final response = await request.send();
        if (response.statusCode == 200) {
          // Success
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                'Time for checking up!',
                style: getBoldStyle(
                  fontSize: FontSize.s25,
                  color: ColorManager.primary,
                ),
              ),
              content: Text(
                'we are checking up your application for safety sir, we holding your auction account and soon we email you and you can bid for all products you want.',
                style: getMediumStyle(
                  fontSize: FontSize.s20,
                  color: ColorManager.black,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      MainView.routeName,
                    );
                  },
                  child: Text(
                    'OK',
                    style: getBoldStyle(
                        fontSize: FontSize.s20, color: ColorManager.primary),
                  ),
                ),
              ],
            ),
          );
        } else {
          // Error
          ErrorViewer.showError(
              context: context,
              error: const CustomError(message: 'Failed to submit bid'),
              callback: () {});
        }
      } catch (e) {
        ErrorViewer.showError(
            context: context,
            error: const CustomError(message: 'Failed to submit bid'),
            callback: () {});
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill all fields and upload images')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your full name';
                }
                return null;
              },
            ),
            20.vGap,
            CustomTextFormField(
              labelText: 'SSN ',
              hintText: 'Enter your SSN',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your SSN';
                }
                if (value.length != 14) return 'SSN must be 14 digits';
                return null;
              },
              inputType: TextInputType.number,
              controller: _ssnController,
              iconData: Icons.credit_card,
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
                    });
                  },
                  title: 'Upload your ID Photo',
                ),
                if (!_isIdImageSelected &&
                    _formKey.currentState?.validate() == true)
                  Text(
                    'Please upload your ID Photo',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
              ],
            ),
            20.vGap,
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
                "Bank masr1 ",
                "Bank masr2",
                "Bank elahly 1",
                "Bank elahly 2",
              ],
              validator: (value) => _validateRequired(value, "Bank Name"),
              onChanged: (value) {},
            ),
            20.vGap,
            CustomTextFormField(
              controller: _ibanController,
              hintText: "Enter your IBAN",
              labelText: 'IBAN',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your IBAN';
                }
                if (value.length != 14) {
                  return 'Please enter a valid IBAN';
                }
                return null;
              },
              iconData: Icons.edit_document,
              inputType: TextInputType.number,
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
                    });
                  },
                  title: 'Upload your IBAN Photo',
                ),
                if (!_isIbanImageSelected &&
                    _formKey.currentState?.validate() == true)
                  const Text(
                    'Please upload your IBAN Photo',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
              ],
            ),
            20.vGap,
            CustomElevatedButtonWithoutStream(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Validate images
                  final idImageError =
                      _validateImage(_isIdImageSelected, 'ID Photo');
                  final ibanImageError =
                      _validateImage(_isIbanImageSelected, 'IBAN Photo');

                  print(idImageError);
                  if (idImageError != null || ibanImageError != null) {
                    // Show error messages for images
                    ErrorViewer.showError(
                      context: context,
                      error: CustomError(
                          message: idImageError ?? ibanImageError ?? ''),
                      callback: () {},
                    );
                  } else {
                    // All validations passed, proceed with form submission
                    _submitForm();
                  }
                }
              },
              text: 'Continue',
            ),
          ],
        ),
      ),
    );
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _validateImage(bool isImageSelected, String fieldName) {
    if (!isImageSelected) {
      return 'Please upload your $fieldName';
    }
    return null;
  }
}
