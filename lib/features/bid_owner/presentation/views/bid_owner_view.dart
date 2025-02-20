import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peakmart/core/resources/assets_manager.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/shared_widgets/buttons.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:peakmart/features/bid_owner/data/models/request/add_product_request.dart';
import 'package:peakmart/features/bid_owner/presentation/state_mang/add_product_cubit/add_product_cubit.dart';
import 'package:peakmart/features/bid_owner/presentation/widgets/place_bid_accept_data.dart';
import 'package:peakmart/features/bid_owner/presentation/widgets/upload_image_widget.dart';

class BidOwnerView extends StatefulWidget {
  const BidOwnerView({super.key});
  static const routeName = "/bid_owner";

  @override
  State<BidOwnerView> createState() => _BidOwnerViewState();
}

class _BidOwnerViewState extends State<BidOwnerView> {
  bool isButtonActive = false;
  late String image;
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
                  // SizedBox(height: 23.h),
                  UploadImageWidget(image: (pathOfImage) {
                    setState(() {
                      image = pathOfImage;
                    });
                  }),
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

                  BlocConsumer<AddProductCubit, AddProductState>(
                    listener: (context, state) {
                      if (state is AddProductLoadingState) {
                        log("Loading state in add product view");
                      }
                      if (state is AddProductSuccessState) {
                        log("Success state in add product view");
                        dynamic response = state.addProductEntity;
                        log("Response in add product view: $response");
                      }
                      if (state is AddProductFailureState) {
                        log("Failure state in add product view");
                        dynamic error = state.errors;
                        log("Error in add product view: $error");
                      }
                    },
                    builder: (context, state) {
                      return CustomElevatedButtonWithoutStream(
                        onPressed: !isButtonActive
                            ? null
                            : () {
                                if (key.currentState!.validate()) {
                                  key.currentState!.save();
                                  final addProductRequest = AddProductRequest(
                                    photo: image,
                                    name: productNameController.text,
                                    description: descriptionController.text,
                                    startingPrice: double.tryParse(
                                            startingPriceController.text) ??
                                        0,
                                    expectedPrice: double.tryParse(
                                            expectedPriceController.text) ??
                                        0,
                                    location: locationController.text,
                                    startDate: startDateController.text,
                                    deliveryDate: arrivalDateController.text,
                                    periodOfBid: int.tryParse(
                                            periodOfBidsController.text) ??
                                        0,
                                    categoryId: 1,
                                  );
                                  log("AddProductRequest: $addProductRequest");
                                  log("Image photo: $image, Product name: ${productNameController.text}, description: ${descriptionController.text}, starting price: ${startingPriceController.text}, Expected price: ${expectedPriceController.text}, location: ${locationController.text}, start date: ${startDateController.text}, arrival date: ${arrivalDateController.text}, period of bids: ${periodOfBidsController.text}");
                                  // context.read<AddProductCubit>().addProduct(
                                  //     addProductRequest: addProductRequest);
                                }
                              },
                        text: AppStrings.placeBid,
                      );
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class ImageUploadWidget extends StatefulWidget {
  const ImageUploadWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ImageUploadWidgetState createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: double.infinity,
        height: 120.h,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.grey),
        ),
        child: _image == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(IconsAssets.pickerIcon),
                  SizedBox(height: 10.h),
                  Text(AppStrings.addProductPhoto,
                      style: getMediumStyle(
                        color: ColorManager.grey1,
                        fontSize: FontSize.s14,
                      )),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(_image!,
                    fit: BoxFit.cover, width: double.infinity, height: 200),
              ),
      ),
    );
  }
}

/*
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peakmart/core/resources/assets_manager.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/shared_widgets/buttons.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:peakmart/features/bid_owner/data/models/request/add_product_request.dart';
import 'package:peakmart/features/bid_owner/presentation/state_mang/add_product_cubit/add_product_cubit.dart';
import 'package:peakmart/features/bid_owner/presentation/widgets/place_bid_accept_data.dart';
import 'package:peakmart/features/bid_owner/presentation/widgets/upload_image_widget.dart';

class BidOwnerView extends StatefulWidget {
  const BidOwnerView({super.key});
  static const routeName = "/bid_owner";

  @override
  State<BidOwnerView> createState() => _BidOwnerViewState();
}

class _BidOwnerViewState extends State<BidOwnerView> {

  bool isButtonActive = false;
  late String image;
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
              child: BlocConsumer<AddProductCubit, AddProductState>(
                listener: (context, state) {
                  if (state is AddProductLoadingState) {
                    log("Loading state in add product view");
                  }
                  if (state is AddProductSuccessState) {
                    log("Success state in add product view");
                    dynamic response = state.addProductEntity;
                    log("Response in add product view: $response");
                  }
                  if (state is AddProductFailureState) {
                    log("Failure state in add product view");
                    dynamic error = state.errors;
                    log("Error in add product view: $error");
                  }
                },
                builder: (context, state) {
                  return ListView(
                    children: [
                      // SizedBox(height: 23.h),
                      UploadImageWidget(image: (pathOfImage) {
                        setState(() {
                          image = pathOfImage;
                        });
                      }),
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
                                  final addProductRequest = AddProductRequest(
                                    photo: image,
                                    name: productNameController.text,
                                    description: descriptionController.text,
                                    startingPrice: double.tryParse(
                                            startingPriceController.text) ??
                                        0,
                                    expectedPrice: double.tryParse(
                                            expectedPriceController.text) ??
                                        0,
                                    location: locationController.text,
                                    startDate: startDateController.text,
                                    deliveryDate: arrivalDateController.text,
                                    periodOfBid: int.tryParse(
                                            periodOfBidsController.text) ??
                                        0,
                                    categoryId: 1,
                                  );
                                  log("AddProductRequest: $addProductRequest");
                                  log("Image photo: $image, Product name: ${productNameController.text}, description: ${descriptionController.text}, starting price: ${startingPriceController.text}, Expected price: ${expectedPriceController.text}, location: ${locationController.text}, start date: ${startDateController.text}, arrival date: ${arrivalDateController.text}, period of bids: ${periodOfBidsController.text}");
                                  // context.read<AddProductCubit>().addProduct(
                                  //     addProductRequest: addProductRequest);
                                }
                              },
                        text: AppStrings.placeBid,
                      ),
                    ],
                  );
                },
              ),
            )),
      ),
    );
  }
}

class ImageUploadWidget extends StatefulWidget {
  const ImageUploadWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ImageUploadWidgetState createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: double.infinity,
        height: 120.h,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.grey),
        ),
        child: _image == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(IconsAssets.pickerIcon),
                  SizedBox(height: 10.h),
                  Text(AppStrings.addProductPhoto,
                      style: getMediumStyle(
                        color: ColorManager.grey1,
                        fontSize: FontSize.s14,
                      )),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(_image!,
                    fit: BoxFit.cover, width: double.infinity, height: 200),
              ),
      ),
    );
  }
}


*/