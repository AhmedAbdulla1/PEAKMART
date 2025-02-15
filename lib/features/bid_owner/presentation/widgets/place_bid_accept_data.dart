import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_text_form_field.dart';
import 'package:peakmart/features/bid_owner/presentation/widgets/custom_date_field.dart';

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
        SizedBox(
          height: 23.h,
        ),
        CustomTextFormField(
            labelText: AppStrings.description,
            hintText: AppStrings.description,
            isShowDescription: true,
            isUsedWithBidOwner: true,
            inputType: TextInputType.multiline,
            controller: descriptionController),
        SizedBox(
          height: 23.h,
        ),
        CustomTextFormField(
            labelText: AppStrings.startingPrice,
            hintText: AppStrings.startingPrice,
            inputType: TextInputType.number,
            isUsedWithBidOwner: true,
            controller: startingPriceController),
        SizedBox(
          height: 23.h,
        ),
        CustomTextFormField(
            labelText: AppStrings.expectedPrice,
            hintText: AppStrings.expectedPrice,
            isUsedWithBidOwner: true,
            inputType: TextInputType.number,
            controller: expectedPriceController),
        SizedBox(
          height: 23.h,
        ),
        CustomTextFormField(
            labelText: AppStrings.location,
            hintText: AppStrings.location,
            isUsedWithBidOwner: true,
            inputType: TextInputType.text,
            controller: locationController),
        SizedBox(
          height: 23.h,
        ),
        CustomDateField(
            controller: startDateController, labelText: AppStrings.startDate,),
        SizedBox(
          height: 23.h,
        ),CustomDateField(
            controller: arrivalDateController, labelText: AppStrings.arrivalDate),
        
        SizedBox(
          height: 23.h,
        ),
        CustomTextFormField(
            labelText: AppStrings.periodOfBids,
            hintText: AppStrings.periodOfBids,
            isUsedWithBidOwner: true,
            inputType: TextInputType.number,
            controller: periodOfBidsController),
      ],
    );
  }
}
