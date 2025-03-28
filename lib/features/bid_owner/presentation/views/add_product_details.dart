import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:peakmart/core/error_ui/dialogs/show_dialog.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/auth/presentation/views/reset_password/widgets/success_bottom_sheet.dart';
import 'package:peakmart/features/bid_owner/data/models/request/add_product_request.dart';
import 'package:peakmart/features/bid_owner/presentation/state_mang/add_product_cubit/add_product_cubit.dart';

import '../../../../core/resources/style_manager.dart';

class AddProductDetails extends StatefulWidget {
  static const String routeName = '/add_product_details';
  final AddProductRequest addProductRequest;

  const AddProductDetails({super.key, required this.addProductRequest});

  @override
  State<AddProductDetails> createState() => _AddProductDetailsState();
}

class _AddProductDetailsState extends State<AddProductDetails> {
  int selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductCubit(),
      child: Scaffold(
        appBar: AppBar(
          title:  Text(AppStrings.productDetails,
              style: getBoldStyle(
                  fontSize: FontSize.s25, color: ColorManager.white)),
          backgroundColor: ColorManager.primary,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: ColorManager.white, size: FontSize.s28),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: BlocConsumer<AddProductCubit, AddProductState>(
            listener: (context, state) {
              if (state is AddProductLoadingState) {
                ShowDialog().showElasticDialog(
                  context: context,
                  builder: (context) => const WaitingWidget(),
                  barrierDismissible: false,
                );
              } else {
                Navigator.pop(context);
                if (state is AddProductSuccessState) {
                  showSuccessBottomSheet(
                      context, AppStrings.productAddedSuccessfully);
                } else if (state is AddProductFailureState) {
                  showSuccessBottomSheet(
                      context, AppStrings.productAddedSuccessfully);
                }
                // ShowDialog().showElasticDialog(
                //   context: context,
                //   builder: (context) => AlertDialog(
                //     title: const Text("Error"),
                //     content: Text(state.errors.toString()),
                //     actions: [
                //       TextButton(
                //         onPressed: () => Navigator.pop(context),
                //         child: const Text("OK"),
                //       ),
                //     ],
                //   ),
                // );      //* edit in future
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMainImage(),
                  16.vGap,
                  _buildThumbnailList(),
                  24.vGap,
                  _buildProductNameAndDescription(),
                  12.vGap,
                  _buildProductDetails(),
                  24.vGap,
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          log("on Pressed add product button");
                          BlocProvider.of<AddProductCubit>(context).addProduct(
                              addProductRequest: widget.addProductRequest);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text(
                          AppStrings.addProduct,
                        )),
                  ),
                  50.vGap,
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void showSuccessBottomSheet(BuildContext context, String message) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SuccessBottomSheet(
          isUsedWithProductDetails: true,
          textMessage: message,
        );
      },
    );
  }

  Widget _buildMainImage() {
    return Container(
      height: 250.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        image: DecorationImage(
          image: FileImage(widget.addProductRequest.photos[selectedImageIndex]),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildThumbnailList() {
    return SizedBox(
      height: 90.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.addProductRequest.photos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => setState(() => selectedImageIndex = index),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: selectedImageIndex == index
                      ? ColorManager.primary
                      : Colors.grey,
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.file(
                  widget.addProductRequest.photos[index],
                  fit: BoxFit.cover,
                  width: 80.w,
                  height: 80.h,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductNameAndDescription() {
    return Column(
      children: [
        Text(widget.addProductRequest.name,
            style: getBoldStyle(fontSize: FontSize.s22)),
        12.vGap,
        Text(widget.addProductRequest.description,
            style: getRegularStyle(
                fontSize: FontSize.s16,
                color: context.isDarkMode
                    ? ColorManager.grey
                    : Colors.grey[700]!)),
      ],
    );
  }

  Widget _buildInfoRow(String title, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Icon(icon, color: ColorManager.primary, size: 20),
          SizedBox(width: 16.w),
          Text(title, style: getBoldStyle(fontSize: FontSize.s16)),
          const Spacer(),
          Text(value,
              style: getRegularStyle(
                  fontSize: FontSize.s16,
                  color: context.isDarkMode
                      ? ColorManager.grey
                      : Colors.grey[800]!)),
        ],
      ),
    );
  }

  Widget _buildProductDetails() {
    return Column(
      children: [
        _buildInfoRow("Location", widget.addProductRequest.location,
            FontAwesomeIcons.mapMarkerAlt),
        _buildInfoRow(AppStrings.auctionStart,
            widget.addProductRequest.startDate, FontAwesomeIcons.calendarAlt),
        _buildInfoRow(
            AppStrings.deliveryDate,
            widget.addProductRequest.deliveryDate,
            FontAwesomeIcons.calendarCheck),
        _buildInfoRow(
            AppStrings.startingPrice,
            "\$${widget.addProductRequest.startingPrice}",
            FontAwesomeIcons.dollarSign),
        _buildInfoRow(
            AppStrings.expectedPrice,
            "\$${widget.addProductRequest.expectedPrice}",
            FontAwesomeIcons.moneyBillWave),
        _buildInfoRow(
            AppStrings.biddingPeriod,
            "${widget.addProductRequest.periodOfBid} days",
            FontAwesomeIcons.hourglassHalf),
        _buildInfoRow(AppStrings.category, AppStrings.electronics,
            FontAwesomeIcons.layerGroup),
      ],
    );
  }
}
