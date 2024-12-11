import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:peakmart/app/resources/color_manager.dart';
import 'package:peakmart/app/resources/font_manager.dart';
import 'package:peakmart/app/resources/string_manager.dart';
import 'package:peakmart/app/resources/style_manager.dart';
import 'package:peakmart/app/resources/values_manager.dart';

class CustomPhoneTextField extends StatelessWidget {
  const CustomPhoneTextField(
      {super.key,
      required this.controller,
      required this.onCountryChanged,
      this.autoFocus = false});

  final TextEditingController controller;
  final bool autoFocus;

  final void Function(Country) onCountryChanged;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.phone,
      cursorRadius: const Radius.circular(20),
      cursorColor: ColorManager.primary,
      style: getRegularStyle(
        color: ColorManager.grey1,
        fontSize: FontSize.s22,
      ),
      dropdownTextStyle: TextStyle(
        color: ColorManager.grey1,
        fontSize: FontSize.s20,
        fontWeight: FontWeightManager.medium,
      ),
      dropdownDecoration: BoxDecoration(
        color: ColorManager.primary,
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow((RegExp("[0-9]"))),
      ],
      controller: controller,
      invalidNumberMessage: AppStrings.phoneError,
      showDropdownIcon: false,
      initialCountryCode: 'SA',
      pickerDialogStyle: PickerDialogStyle(
        searchFieldCursorColor: ColorManager.grey1,
        countryCodeStyle: TextStyle(
          color: ColorManager.grey1,
          fontSize: FontSize.s20,
          fontWeight: FontWeightManager.medium,
        ),
        countryNameStyle: TextStyle(
          color: ColorManager.grey1,
          fontSize: FontSize.s20,
          fontWeight: FontWeightManager.medium,
        ),
        searchFieldPadding: const EdgeInsets.only(
            top: AppPadding.p8, right: AppPadding.p8, left: AppPadding.p8),
        searchFieldInputDecoration: InputDecoration(
          hintText: AppStrings.searchCountry,
          hintStyle: getMediumStyle(
            color: ColorManager.primary,
            fontSize: FontSize.s20,
          ),
          alignLabelWithHint: true,
        ),
      ),
      onCountryChanged: onCountryChanged,
      autofocus: autoFocus,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        hintText: AppStrings.phone,
        contentPadding: EdgeInsets.symmetric(horizontal: AppPadding.p28.h),
      ),
    );
  }
}

class CustomTextFormWithStream extends StatelessWidget {
  const CustomTextFormWithStream({
    super.key,
    required this.stream,
    required this.textEditingController,
    this.textInputType = TextInputType.text,
    this.onComplete,
    this.onTap,
    this.prefixIcon,
    this.textInputAction,
    required this.hintText,
    this.maxLines = 1,
    this.minLines = 1,
    this.enabled = true,
  });

  final Stream<String?> stream;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final Widget? prefixIcon;
  final Function()? onComplete;
  final Function()? onTap;
  final TextInputAction? textInputAction;
  final String hintText;
  final int maxLines;
  final int minLines;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: stream,
      builder: (context, snapshot) => TextFormField(
        cursorRadius: const Radius.circular(20),
        cursorColor: ColorManager.primary,
        // maxLines: 20,
        minLines: minLines,
        maxLines: maxLines,
        enabled: enabled,
        onTap: onTap,
        style: TextStyle(
          color: ColorManager.grey1,
        ),
        // expands: true,
        keyboardType: textInputType,
        controller: textEditingController,
        onEditingComplete: onComplete,
        textInputAction: textInputAction,
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            iconColor: ColorManager.grey1,
            labelText: hintText,
            errorText: snapshot.data,
            errorStyle: TextStyle(
              fontSize: FontSize.s12,
            )),
      ),
    );
  }
}

class PasswordTextFieldWithStream extends StatefulWidget {
  const PasswordTextFieldWithStream({
    super.key,
    required this.stream,
    required this.textEditingController,
    this.onComplete,
    this.onTap,
  });

  final Stream<String?> stream;
  final TextEditingController textEditingController;
  final Function()? onComplete;
  final Function()? onTap;

  @override
  State<PasswordTextFieldWithStream> createState() =>
      _PasswordTextFieldWithStreamState();
}

class _PasswordTextFieldWithStreamState
    extends State<PasswordTextFieldWithStream> {
  bool obscureText = true;

  void onIconPressed() {
    print(obscureText);
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: widget.stream,
      builder: (context, snapshot) => TextFormField(
        cursorRadius: const Radius.circular(10),
        cursorColor: ColorManager.primary,
        style: TextStyle(color: ColorManager.grey1),
        keyboardType: TextInputType.visiblePassword,
        controller: widget.textEditingController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: ColorManager.grey1,
          ),
          suffixIcon: InkWell(
            onTap: onIconPressed,
            child: Icon(
              obscureText
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: ColorManager.grey1,
            ),
          ),
          labelText: AppStrings.password,
          errorText: snapshot.data,
        ),
        obscureText: obscureText,
        obscuringCharacter: "*",
      ),
    );
  }
}
