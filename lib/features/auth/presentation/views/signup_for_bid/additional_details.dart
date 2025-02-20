import 'dart:io';

import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/shared_widgets/image_picker.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_text_form_field.dart';
import 'package:peakmart/features/auth/presentation/views/signup_for_bid/widgets/dropdown_menu.dart';

class AdditionalDetails extends StatelessWidget {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _ssnController = TextEditingController();
  final TextEditingController _bankController = TextEditingController();
  final TextEditingController _ibanController = TextEditingController();

  AdditionalDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          ),
          20.vGap,
          CustomTextFormField(
            labelText: 'SSN ',
            hintText: 'Enter your SSN',
            inputType: TextInputType.name,
            controller: _ssnController,
            iconData: Icons.credit_card,
          ),
          20.vGap,
          ImagePickerWidget(
            onImageSelected: (File? image) {
              print(image?.path);
            },
            title: 'Upload your ID Photo',
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
            items: ["Bank massr1 ", "Bank massr2", "Bank massr 3","Bank massr4" ],
            validator: (value) => _validateRequired(value, "Country"),
            onChanged: (value) {},
          ),
          20.vGap,
          CustomTextFormField(
            controller: _ibanController,
            hintText: "Enter your IBAN",
            labelText: 'IBAN',
            iconData: Icons.edit_document,
            inputType: TextInputType.name,
          ),
          20.vGap,
          ImagePickerWidget(
            onImageSelected: (File? image) {
              print(image?.path);
            },
            title: 'Upload your ID Photo',
          ),
        ],
      ),
    );
  }
  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }
}
