import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/shared_widgets/buttons.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:peakmart/features/bid_owner/data/models/request/add_product_request.dart';
import 'package:peakmart/features/bid_owner/presentation/state_mang/add_product_cubit/add_product_cubit.dart';
import 'package:peakmart/features/bid_owner/presentation/state_mang/add_product_cubit/image_picker_controller.dart';
import 'package:peakmart/features/bid_owner/presentation/views/widgets/place_bid_accept_data.dart';
import 'package:provider/provider.dart';

import '../../../../core/shared_widgets/image_picker_new.dart';

class BidOwnerView extends StatefulWidget {
  const BidOwnerView({super.key});

  static const routeName = "/bid_owner";

  @override
  State<BidOwnerView> createState() => _BidOwnerViewState();
}

List<File?> productImages = [];

class _BidOwnerViewState extends State<BidOwnerView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ImagePickerController(),
      child: SafeArea(
        child: BlocProvider(
          create: (context) => AddProductCubit(),
          child: Scaffold(
            appBar: const CustomAppBar(title: AppStrings.placeBid),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 29.sp, vertical: 32.sp),
              child: ListView(
                children: [
                  const ImagePicker(title: AppStrings.addProductPhoto),
                  23.verticalSpace,
                  PlaceBidAcceptData(
                    productNameController: TextEditingController(),
                    descriptionController: TextEditingController(),
                    startingPriceController: TextEditingController(),
                    expectedPriceController: TextEditingController(),
                    locationController: TextEditingController(),
                    startDateController: TextEditingController(),
                    arrivalDateController: TextEditingController(),
                    periodOfBidsController: TextEditingController(),
                  ),
                  23.verticalSpace,
                  BlocConsumer<AddProductCubit, AddProductState>(
                    listener: (context, state) {
                      if (state is AddProductLoadingState) {
                        debugPrint("Loading...");
                      } else if (state is AddProductSuccessState) {
                        debugPrint("Success!");
                      } else if (state is AddProductFailureState) {
                        debugPrint("Error: ${state.errors}");
                      }
                    },
                    builder: (context, state) {
                      return Consumer<ImagePickerController>(
                        builder: (context, imageController, child) {
                          return CustomElevatedButtonWithoutStream(
                            onPressed: imageController.images.isEmpty
                                ? null
                                : () {
                                    final addProductRequest = AddProductRequest(
                                      photo: imageController.images.first.path,
                                      name: "Product Name",
                                      description: "Description",
                                      startingPrice: 100,
                                      expectedPrice: 200,
                                      location: "Cairo",
                                      startDate: "2025-03-01",
                                      deliveryDate: "2025-03-10",
                                      periodOfBid: 7,
                                      categoryId: 1,
                                    );
                                    log(addProductRequest.toJson().toString());
                                    context.read<AddProductCubit>().addProduct(
                                          addProductRequest: addProductRequest,
                                        );
                                  },
                            text: AppStrings.placeBid,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
