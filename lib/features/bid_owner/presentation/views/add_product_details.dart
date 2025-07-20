import 'package:Bid_Mart/core/error_ui/dialogs/show_dialog.dart';
import 'package:Bid_Mart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:Bid_Mart/core/error_ui/error_viewer/toast/errv_toast_options.dart';
import 'package:Bid_Mart/core/error_ui/toast.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/extentions.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/string_manager.dart';
import 'package:Bid_Mart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:Bid_Mart/core/resources/values_manager.dart';
import 'package:Bid_Mart/core/widgets/waiting_widget.dart';
import 'package:Bid_Mart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:Bid_Mart/features/auth/presentation/views/reset_password/widgets/success_bottom_sheet.dart';
import 'package:Bid_Mart/features/bid_owner/data/models/request/add_product_request.dart';
import 'package:Bid_Mart/features/bid_owner/presentation/state_mang/add_product_cubit/add_product_cubit.dart';
import 'package:Bid_Mart/features/payment/domain/enum/enums.dart';
import 'package:Bid_Mart/features/payment/presentation/views/payment_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        appBar: const CustomAppBar(title: "Product Details"),
        body: BlocConsumer<AddProductCubit, AddProductState>(
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
                ErrorViewer.showError(
                    errorViewerOptions: const ErrVToastOptions(
                        backGroundColor: ColorManager.textFormErrorBorder,
                        textColor: ColorManager.white),
                    context: context,
                    error: state.errors,
                    callback: () {
                      BlocProvider.of<AddProductCubit>(context).addProduct(
                          addProductRequest: widget.addProductRequest);
                    });
              }
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppPadding.p16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildMainImage(),
                        16.vGap,
                        _buildThumbnailList(),
                        24.vGap,
                        _buildProductNameAndDescription(),
                        12.vGap,
                        _buildProductDetails(),
                        24.vGap, // Keep this gap to separate content from button
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppPadding.p20,
                      AppPadding.p8,
                      AppPadding.p20,
                      AppPadding.p30), // Adjust padding as needed
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => PaymentDialog(
                              netPrice: widget.addProductRequest.startingPrice,
                              paymentProcess: PaymentProcess.upload),
                        ).then((value) {
                          if (value.containsKey('payment_status') &&
                              value['payment_status'] == 'success') {
                            context.read<AddProductCubit>().addProduct(
                                  addProductRequest:
                                      widget.addProductRequest.copyWith(
                                    tabId: value['tap_id'],
                                    amount: value['fees'].toString(),
                                  ),
                                );

                            Toast.show("Product successfully Uploaded",
                                backgroundColor: ColorManager.green);
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        AppStrings.addProduct,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
          Icon(icon, color: context.primaryColor, size: 20),
          SizedBox(width: 16.w),
          Text(title, style: getBoldStyle(fontSize: FontSize.s16)),
          const Spacer(),
          Text(value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: getRegularStyle(
                  fontSize: FontSize.s16,
                  color: context.isDarkMode
                      ? ColorManager.grey
                      : Colors.grey[800]!)),
        ],
      ),
    );
  }

  Widget _buildLocationItem() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          children: [
            Icon(FontAwesomeIcons.locationDot,
                color: context.primaryColor, size: 20),
            16.hGap,
            Text("Location: ", style: getBoldStyle(fontSize: FontSize.s16)),
            const Spacer(),
            Text(widget.addProductRequest.address!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: getRegularStyle(
                    fontSize: FontSize.s16,
                    color: context.isDarkMode
                        ? ColorManager.grey
                        : Colors.grey[800]!)),
          ],
        ),
      ),
    );
  }

  Widget _buildProductDetails() {
    return Column(
      children: [
        _buildLocationItem(),
        _buildInfoRow(AppStrings.auctionStart,
            widget.addProductRequest.startDate, FontAwesomeIcons.calendarDay),
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
        _buildInfoRow(
            AppStrings.category,
            widget.addProductRequest.categoryName!,
            FontAwesomeIcons.layerGroup),
      ],
    );
  }
}
