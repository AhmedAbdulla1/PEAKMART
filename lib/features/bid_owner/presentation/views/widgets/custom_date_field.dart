import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';

class CustomDateField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool allowFutureDates;
  final DateTimeType dateTimeType;
  final bool isStartDate;

  const CustomDateField({
    super.key,
    required this.controller,
    this.labelText = "Enter Date",
    this.firstDate,
    this.lastDate,
    this.allowFutureDates = true,
    this.isStartDate = false,
    this.dateTimeType = DateTimeType.generalDate,
  });

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');

  Future<void> _selectDate(BuildContext context) async {
    late DateTime initialDate;
    late DateTime firstDate;
    late DateTime lastDate;
    switch (widget.dateTimeType) {
      case DateTimeType.startDate:
        initialDate = widget.firstDate!.add(const Duration(days: 3));
        firstDate = widget.firstDate!.add(const Duration(days: 3));
        lastDate = widget.lastDate ?? DateTime(2100);
        break;
      case DateTimeType.deliveryDate:
        initialDate = DateTime.now();
        firstDate = DateTime.now();
        lastDate = widget.lastDate ?? DateTime(2100);
        break;
      case DateTimeType.generalDate:
      default:
        initialDate = DateTime.now();
        firstDate = widget.firstDate ?? DateTime(1900);
        lastDate = widget.lastDate ?? DateTime(2100);
    }

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        widget.controller.text = _dateFormat.format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () => _selectDate(context),
      style: getRegularStyle(
        color: context.isDarkMode
            ? ColorManager.darkModePrimary
            : ColorManager.primary,
        fontSize: FontSize.s16,
      ),
      controller: widget.controller,
      keyboardType: TextInputType.datetime,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: "DD-MM-YYYY",
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          icon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.calendar_today,
              color: ColorManager.textFormIcon,
            ),
          ),
          onPressed: () => _selectDate(context),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}

enum DateTimeType { startDate, deliveryDate, generalDate }
