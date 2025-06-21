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
    int? starting = int.tryParse(startingPriceController.text);
    int? expected = int.tryParse(expectedPriceController.text);
    if (starting == null || expected == null) return "Enter valid numbers";
    if (starting < 0 || expected < 0) return "Price cannot be negative";
    if (starting >= expected) return "Expected must be > starting";
    return null;
  }

  String? validatePeriod() {
    final input = periodOfBidsController.text.trim();
    final value = int.tryParse(input);
    if (input.isEmpty) return "Enter period of bids";
    if (value == null) return "Must be a number";
    if (value <= 0) return "Must be > 0";
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Selected Address: $address')),
        );
        locationController.text = address;
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
          controller: locationController,
          suffixIcon: IconButton(
            onPressed: () => onLocationPressed(context),
            icon: const Icon(Icons.location_on),
          ),
        ),
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
          inputFormatter: [FilteringTextInputFormatter.digitsOnly],
          validator: (_) => validatePeriod(),
          inputType: TextInputType.number,
          controller: periodOfBidsController,
        ),
      ],
    );
  }
}
