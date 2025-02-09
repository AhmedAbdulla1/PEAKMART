import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/shared_widgets/buttons.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:peakmart/features/bid_owner/presentation/widgets/place_bid_accept_data.dart';

class BidOwnerView extends StatefulWidget {
  const BidOwnerView({super.key});
  static const routeName = "/bid_owner";

  @override
  State<BidOwnerView> createState() => _BidOwnerViewState();
}

class _BidOwnerViewState extends State<BidOwnerView> {
  bool isButtonActive = false;
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController startingPriceController = TextEditingController();
  final TextEditingController expectedPriceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController arrivalDateController = TextEditingController();
  final TextEditingController periodOfBidsController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    productNameController.addListener(_checkFormValidation);
    descriptionController.addListener(_checkFormValidation);
    startingPriceController.addListener(_checkFormValidation);
    expectedPriceController.addListener(_checkFormValidation);
    locationController.addListener(_checkFormValidation);
    startDateController.addListener(_checkFormValidation);
    arrivalDateController.addListener(_checkFormValidation);
    periodOfBidsController.addListener(_checkFormValidation);
  }

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    startingPriceController.dispose();
    expectedPriceController.dispose();
    locationController.dispose();
    startDateController.dispose();
    arrivalDateController.dispose();
    periodOfBidsController.dispose();
    super.dispose();
  }

  void _checkFormValidation() {
    bool allFieldsFilled = productNameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        startingPriceController.text.isNotEmpty &&
        expectedPriceController.text.isNotEmpty &&
        locationController.text.isNotEmpty &&
        startDateController.text.isNotEmpty &&
        arrivalDateController.text.isNotEmpty &&
        periodOfBidsController.text.isNotEmpty;

    if (isButtonActive != allFieldsFilled) {
      setState(() {
        isButtonActive = allFieldsFilled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: AppStrings.placeBid),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 29.sp, vertical: 32.sp),
            child: Form(
              key: key,
              child: ListView(
                children: [
                  SizedBox(height: 23.h),
                  PlaceBidAcceptData(
                    productNameController: productNameController,
                    descriptionController: descriptionController,
                    startingPriceController: startingPriceController,
                    expectedPriceController: expectedPriceController,
                    locationController: locationController,
                    startDateController: startDateController,
                    arrivalDateController: arrivalDateController,
                    periodOfBidsController: periodOfBidsController,
                  ),
                  SizedBox(height: 23.h),
                  CustomElevatedButtonWithoutStream(
                    onPressed: !isButtonActive
                        ? null
                        : () {
                            if (key.currentState!.validate()) {
                              key.currentState!.save();
                              log("Product name: ${productNameController.text}, description: ${descriptionController.text}, starting price: ${startingPriceController.text}");
                            }
                          },
                    text: AppStrings.placeBid,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
