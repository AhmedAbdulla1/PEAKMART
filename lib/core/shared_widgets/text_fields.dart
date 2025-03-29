import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:peakmart/core/resources/values_manager.dart';

class CustomPhoneTextField extends StatelessWidget {
  const CustomPhoneTextField({
    super.key,
    required this.controller,
    this.onCountryChanged,
    this.autoFocus = false,
  });

  final TextEditingController controller;
  final bool autoFocus;
  final void Function(Country)? onCountryChanged;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.phone,
      cursorColor: ColorManager.primary,
      style: getRegularStyle(
        color: context.isDarkMode
            ? ColorManager.darkModePrimary
            : ColorManager.primary,
        fontSize: FontSize.s16,
      ),
      dropdownTextStyle: getRegularStyle(
        color: context.isDarkMode ? ColorManager.grey : ColorManager.grey1,
        fontSize: FontSize.s16,
      ),
      initialCountryCode: 'EG',
      dropdownDecoration: BoxDecoration(
        color: ColorManager.primary.withOpacity(0.01),
        borderRadius: BorderRadius.circular(8.r),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
      ],
      controller: controller,
      invalidNumberMessage: AppStrings.phoneError,
      showDropdownIcon: true,
      pickerDialogStyle: PickerDialogStyle(
        searchFieldCursorColor: ColorManager.grey1,
        countryCodeStyle: getRegularStyle(
          color: context.isDarkMode ? ColorManager.grey : ColorManager.grey1,
          fontSize: FontSize.s16,
        ),
        countryNameStyle: getRegularStyle(
          color: context.isDarkMode ? ColorManager.grey : ColorManager.grey1,
          fontSize: FontSize.s16,
        ),
        searchFieldPadding: EdgeInsets.all(AppPadding.p8.w),
        searchFieldInputDecoration: InputDecoration(
          hintText: AppStrings.searchCountry,
          hintStyle: getMediumStyle(
            color: ColorManager.primary,
            fontSize: FontSize.s16,
          ),
        ),
      ),
      onCountryChanged: onCountryChanged,
      autofocus: autoFocus,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        hintText: AppStrings.phone,
        hintStyle: getRegularStyle(
          color: context.isDarkMode ? ColorManager.grey : ColorManager.grey1,
          fontSize: FontSize.s14,
        ),
        contentPadding: const EdgeInsets.all(
          AppPadding.p16,
        ),
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
  final IconData? prefixIcon;
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
        style: getRegularStyle(
          color: context.isDarkMode
              ? ColorManager.darkModePrimary
              : ColorManager.primary,
          fontSize: FontSize.s16,
        ),
        minLines: minLines,
        maxLines: maxLines,
        enabled: enabled,
        onTap: onTap,

        // expands: true,
        keyboardType: textInputType,
        controller: textEditingController,
        onEditingComplete: onComplete,
        textInputAction: textInputAction,
        decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon, color: ColorManager.grey1),
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
        style: getRegularStyle(
          color: context.isDarkMode
              ? ColorManager.darkModePrimary
              : ColorManager.primary,
          fontSize: FontSize.s16,
        ),
        cursorColor: ColorManager.primary,
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
              obscureText ? Icons.visibility : Icons.visibility_off,
              color: ColorManager.grey1,
            ),
          ),
          labelText: AppStrings.password,
          errorText: snapshot.data,
        ),
        obscureText: obscureText,
      ),
    );
  }
}
