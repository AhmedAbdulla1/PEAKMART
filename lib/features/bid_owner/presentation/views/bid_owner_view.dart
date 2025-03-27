import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/shared_widgets/buttons.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:peakmart/features/bid_owner/data/models/request/add_product_request.dart';
import 'package:peakmart/features/bid_owner/presentation/state_mang/add_product_cubit/add_product_cubit.dart';
import 'package:peakmart/features/bid_owner/presentation/state_mang/add_product_cubit/image_picker_controller.dart';
import 'package:peakmart/features/bid_owner/presentation/views/add_product_details.dart';
import 'package:peakmart/features/bid_owner/presentation/views/widgets/place_bid_accept_data.dart';
import 'package:provider/provider.dart';

import '../../../../core/shared_widgets/add_product_image_picker.dart';

class BidOwnerView extends StatefulWidget {
  const BidOwnerView({super.key});

  static const routeName = "/bid_owner";

  @override
  State<BidOwnerView> createState() => _BidOwnerViewState();
}

class _BidOwnerViewState extends State<BidOwnerView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ImagePickerController(),
      child: SafeArea(
        child: BlocProvider(
          create: (context) => AddProductCubit()..checkIsASeller(),
          child: BlocConsumer<AddProductCubit, AddProductState>(
              listener: (context, state) {},
              builder: (context, state) {
                return AddProductBody();
              }),
        ),
      ),
    );
  }
}

class AddProductBody extends StatefulWidget {
  const AddProductBody({super.key});

  @override
  State<AddProductBody> createState() => _AddProductBodyState();
}

class _AddProductBodyState extends State<AddProductBody> {
  late TextEditingController productNameController;
  late TextEditingController descriptionController;
  late TextEditingController startingPriceController;
  late TextEditingController expectedPriceController;
  late TextEditingController locationController;
  late TextEditingController startDateController;
  late TextEditingController arrivalDateController;
  late TextEditingController periodOfBidsController;

  @override
  void initState() {
    super.initState();
    productNameController = TextEditingController();
    descriptionController = TextEditingController();
    startingPriceController = TextEditingController();
    expectedPriceController = TextEditingController();
    locationController = TextEditingController();
    startDateController = TextEditingController();
    arrivalDateController = TextEditingController();
    periodOfBidsController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.placeBid),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 29.sp,
        ),
        child: ListView(
          children: [
            const AddProductImagePicker(title: AppStrings.addProductPhoto),
            23.verticalSpace,
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
            23.verticalSpace,
            Consumer<ImagePickerController>(
              builder: (context, imageController, child) {
                return BlocProvider(
                  create: (context) => AddProductCubit(),
                  child: CustomElevatedButtonWithoutStream(
                    onPressed: imageController.images.isEmpty
                        ? null
                        : () {
                            final addProductRequest = AddProductRequest(
                              photos: imageController.images,
                              name: productNameController.text,
                              description: descriptionController.text,
                              startingPrice:
                                  double.parse(startingPriceController.text),
                              expectedPrice:
                                  double.parse(expectedPriceController.text),
                              location: locationController.text,
                              startDate: startDateController.text,
                              deliveryDate: arrivalDateController.text,
                              periodOfBid:
                                  int.parse(periodOfBidsController.text),
                              categoryId: 1,
                            );
                            Navigator.pushNamed(
                              context,
                              AddProductDetails.routeName,
                              arguments: addProductRequest,
                            );
                            log(addProductRequest.toFormData().toString());
                          },
                    text: AppStrings.placeBid,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
    ;
  }
}

/* name: "Dell XPS 15 9530 - 13th Gen Intel Core i9, 32GB RAM, 1TB SSD, NVIDIA RTX 4060, 4K OLED Touch Display",
  description:
      The Dell XPS 15 9530 is a powerhouse designed for professionals and creators who demand top-tier performance.
Featuring a stunning 15.6-inch 4K OLED touch display, it delivers vibrant colors, deep blacks, and incredible clarity.
Powered by the latest 13th Gen Intel Core i9 processor and NVIDIA GeForce RTX 4060 GPU, this laptop handles intensive tasks such as video editing,
3D rendering, and gaming with ease. With 32GB DDR5 RAM and a 1TB PCIe NVMe SSD, you can enjoy blazing-fast performance, seamless multitasking, and ample storage for all your projects.
Its premium aluminum chassis, edge-to-edge keyboard, and immersive audio make it the perfect blend of power, portability, and elegance.
Ideal for content creators, designers, and business professionals looking for a high-performance laptop.
  25008
  40500
  Tanta
  */
