import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peakmart/core/resources/color_manager.dart';

class CustomDateField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool allowFutureDates;

  const CustomDateField({
    super.key,
    required this.controller,
    this.labelText = "Enter Date",
    this.firstDate,
    this.lastDate,
    this.allowFutureDates = true,
  });

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = widget.firstDate ?? DateTime(1900);
    DateTime lastDate = widget.lastDate ?? DateTime(2050);

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

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a date";
    }
    try {
      DateTime parsedDate = _dateFormat.parseStrict(value);
      if (!widget.allowFutureDates && parsedDate.isAfter(DateTime.now())) {
        return "Date cannot be in the future";
      }
    } catch (e) {
      return "Invalid format (DD-MM-YYYY)";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        _DateInputFormatter(),
      ],
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: "DD-MM-YYYY",
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
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
      validator: _validateDate,
    );
  }
}

class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text
        .replaceAll(RegExp(r'\D'), ''); //* Remove non-digit characters

    String formattedText = '';
    if (text.length > 2) {
      formattedText =
          '${text.substring(0, 2)}-${text.substring(2, text.length > 4 ? 4 : text.length)}';
    } else {
      formattedText = text;
    }
    if (text.length > 4) {
      formattedText +=
          '-${text.substring(4, text.length > 8 ? 8 : text.length)}';
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
