import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_text_form_field.dart';
import 'package:peakmart/features/bid_owner/presentation/views/widgets/custom_date_field.dart';

class PlaceBidAcceptData extends StatelessWidget {
  const PlaceBidAcceptData({
    super.key,
    required this.productNameController,
    required this.descriptionController,
    required this.startingPriceController,
    required this.expectedPriceController,
    required this.locationController,
    required this.startDateController,
    required this.arrivalDateController,
    required this.periodOfBidsController,
  });

  final TextEditingController productNameController;
  final TextEditingController descriptionController;
  final TextEditingController startingPriceController;
  final TextEditingController expectedPriceController;
  final TextEditingController locationController;
  final TextEditingController startDateController;
  final TextEditingController arrivalDateController;
  final TextEditingController periodOfBidsController;
  String? validatePrice() {
    if (startingPriceController.text.isEmpty ||
        expectedPriceController.text.isEmpty) {
      return "Both prices are required";
    }
    int? startingPrice = int.tryParse(startingPriceController.text);
    int? expectedPrice = int.tryParse(expectedPriceController.text);

    if (startingPrice == null || expectedPrice == null) {
      return "Please enter valid numeric values";
    }
    if (startingPrice < 0 || expectedPrice < 0) {
      return "Price cannot be negative";
    }
    if (startingPrice >= expectedPrice) {
      return "Expected price must be greater than starting price";
    }
    return null;
  }

  String? validatePeriod() {
    String input = periodOfBidsController.text.trim();
    if (input.isEmpty) {
      return "Please enter period of bids";
    }
    int? period = int.tryParse(input);
    if (period == null) {
      return "Please enter a valid number";
    }
    if (period <= 0) {
      return "Period of bids must be greater than 0";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
            labelText: AppStrings.productName,
            hintText: AppStrings.productName,
            isUsedWithBidOwner: true,
            inputType: TextInputType.text,
            controller: productNameController),
        23.vGap,
        CustomTextFormField(
            labelText: AppStrings.description,
            hintText: AppStrings.description,
            isShowDescription: true,
            isUsedWithBidOwner: true,
            inputType: TextInputType.multiline,
            controller: descriptionController),
        23.vGap,
        CustomTextFormField(
            labelText: AppStrings.startingPrice,
            hintText: AppStrings.startingPrice,
            inputType: TextInputType.number,
            isUsedWithBidOwner: true,
            inputFormatter: [

              FilteringTextInputFormatter.digitsOnly,
            ],            controller: startingPriceController),
        23.vGap,
        CustomTextFormField(
            labelText: AppStrings.expectedPrice,
            hintText: AppStrings.expectedPrice,
            validator: (value) {
              return validatePrice();
            },
            isUsedWithBidOwner: true,
            inputFormatter: [

                FilteringTextInputFormatter.digitsOnly,
            ],
            inputType: TextInputType.number,
            controller: expectedPriceController),
        23.vGap,
        CustomTextFormField(
            labelText: AppStrings.location,
            hintText: AppStrings.location,
            isUsedWithBidOwner: true,
            inputType: TextInputType.text,
            controller: locationController),
        23.vGap,
        CustomDateField(
          controller: startDateController,
          labelText: AppStrings.startDate,
          isStartDate: true,
        ),
        23.vGap,
        CustomDateField(
          controller: arrivalDateController,
          labelText: AppStrings.arrivalDate,
          startDateController: startDateController,
        ),
        23.vGap,
        CustomTextFormField(
            labelText: AppStrings.periodOfBids,
            hintText: AppStrings.periodOfBids,
            isUsedWithBidOwner: true,
            inputFormatter: [

              FilteringTextInputFormatter.digitsOnly,
            ],            validator: (value) {
              return validatePrice();
            },
            inputType: TextInputType.number,
            controller: periodOfBidsController),
      ],
    );
  }
}
