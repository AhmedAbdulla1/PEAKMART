import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_text_form_field.dart';
import 'package:peakmart/features/bid_owner/presentation/views/widgets/custom_date_field.dart';
import 'package:peakmart/features/map_screen/view.dart';

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
    required this.addressController,
  });

  final TextEditingController productNameController;
  final TextEditingController descriptionController;
  final TextEditingController startingPriceController;
  final TextEditingController expectedPriceController;
  final TextEditingController locationController;
  final TextEditingController startDateController;
  final TextEditingController arrivalDateController;
  final TextEditingController periodOfBidsController;
  final TextEditingController addressController;
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
    if (expectedPrice > 3 * startingPrice) {
      return "Expected price must be less than 3 times of the starting price";
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
    if (period < 5) {
      return "Period of bid must be at least 5 days";
    }
    return null;
  }

  void onLocationPressed(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MapLocationScreen()),
    );
    if (result != null && result is Map<String, dynamic>) {
      final address = result['address'];
      final location = result['location'];
      if (address is String && location is LatLng) {
        locationController.text = location.toJson().toString();
        addressController.text = address;
      }
    }
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
          controller: productNameController,
        ),
        23.vGap,
        CustomTextFormField(
          labelText: AppStrings.description,
          hintText: AppStrings.description,
          isShowDescription: true,
          isUsedWithBidOwner: true,
          inputType: TextInputType.multiline,
          controller: descriptionController,
        ),
        23.vGap,
        CustomTextFormField(
          labelText: AppStrings.startingPrice,
          hintText: AppStrings.startingPrice,
          inputType: TextInputType.number,
          isUsedWithBidOwner: true,
          inputFormatter: [FilteringTextInputFormatter.digitsOnly],
          controller: startingPriceController,
        ),
        23.vGap,
        CustomTextFormField(
          labelText: AppStrings.expectedPrice,
          hintText: AppStrings.expectedPrice,
          validator: (_) => validatePrice(),
          isUsedWithBidOwner: true,
          inputFormatter: [FilteringTextInputFormatter.digitsOnly],
          inputType: TextInputType.number,
          controller: expectedPriceController,
        ),
        23.vGap,
        CustomTextFormField(
          labelText: AppStrings.location,
          hintText: AppStrings.location,
          isUsedWithBidOwner: true,
          inputType: TextInputType.text,
          controller: addressController,
          onTap: () => onLocationPressed(context),
          suffixIcon: const IconButton(
            onPressed: null,
            icon: Icon(Icons.location_on),
          ),
        ),
        23.vGap,
        CustomDateField(
          controller: arrivalDateController,
          labelText: AppStrings.deliveryDate,
          dateTimeType: DateTimeType.deliveryDate,
        ),
        23.vGap,
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: arrivalDateController,
          builder: (context, arrivalDateTextValue, child) {
            DateTime? parsedArrivalDate;
            try {
              if (arrivalDateTextValue.text.isNotEmpty) {
                parsedArrivalDate = DateFormat('dd-MM-yyyy')
                    .parseStrict(arrivalDateTextValue.text);
              }
            } catch (e) {
              parsedArrivalDate = null;
            }

            // Calculate the minimum allowed start date
            DateTime? startDateMinDate;
            if (parsedArrivalDate != null) {
              startDateMinDate = parsedArrivalDate;
            }
            return Visibility(
              visible: arrivalDateTextValue.text.isNotEmpty,
              child: Column(
                children: [
                  CustomDateField(
                    controller: startDateController,
                    labelText: AppStrings.startDate,
                    dateTimeType: DateTimeType.startDate,
                    firstDate: startDateMinDate,
                  ),
                  23.vGap,
                ],
              ),
            );
          },
        ),
        CustomTextFormField(
          labelText: AppStrings.periodOfBids,
          hintText: AppStrings.periodOfBids,
          isUsedWithBidOwner: true,
          inputFormatter: [FilteringTextInputFormatter.digitsOnly],
          validator: (_) => validatePeriod(),
          inputType: TextInputType.number,
          controller: periodOfBidsController,
        ),
      ],
    );
  }
}
