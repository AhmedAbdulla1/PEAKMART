import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:peakmart/features/products/presentation/views/product_details/product_details_view.dart';
import 'package:peakmart/features/products/presentation/views/product_details/widgets/product_details_view_body.dart';
import 'package:peakmart/features/profile/presentation/state_m/user_products/user_products_cubit.dart';
import 'package:peakmart/features/profile/presentation/views/user_products/widgets/cancel_and_end_product.dart';
import 'package:peakmart/features/profile/presentation/views/user_products/widgets/product_images_slider.dart';

class ProductsUploadedItemWidget extends StatelessWidget {
  const ProductsUploadedItemWidget({
    super.key,
    required this.product,
    required this.index,
    this.isUsingWithRandomProducts,
  });

  final int index;
  final ProductEntity product;
  final bool? isUsingWithRandomProducts;

  String _getEndDate() {
    final startDate = DateTime.parse(product.startDate!);
    final endDate = startDate.add(Duration(days: product.periodOfBid!));
    return "${endDate.year.toString().padLeft(4, '0')}-"
        "${endDate.month.toString().padLeft(2, '0')}-"
        "${endDate.day.toString().padLeft(2, '0')}";
  }

  Widget _buildStatusWidget(BuildContext context) {
    final status = product.status ?? "";
    switch (status) {
      case "ended":
        return _statusText("Ended", ColorManager.primary);
      case "canceled":
        return _statusText("Canceled", ColorManager.red);
      default:
        return BlocProvider(
          create: (context) => UserProductsCubit(),
          child:  CancelAndEndButtonsWidget(productId:product.id),
        );
    }
  }

  Widget _statusText(String text, Color color) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        text,
        style: getMediumStyle(
          color: color,
          fontSize: 22,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        ProductDetails.routeName,
        arguments: product.id,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: ColorManager.primary, width: 1.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image or placeholder
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.r),
                  topRight: Radius.circular(18.r),
                ),
                child: product.imageUrl.isNotEmpty
                    ? ProductImagesSlider(imageUrls: product.imageUrl)
                    : Image.asset(
                        'assets/images/card.png',
                        width: double.infinity,
                        height: 120.h,
                        fit: BoxFit.cover,
                      ),
              ),

              // Product details
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product name
                    Text(
                      product.name,
                      style: getBoldStyle(fontSize: FontSize.s16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Product description
                    Text(
                      product.description,
                      style: getMediumStyle(
                        fontSize: FontSize.s12,
                        color: context.isDarkMode
                            ? ColorManager.grey
                            : ColorManager.grey1,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    6.vGap,

                    // End date and price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRichText(
                            title: "End Date: ", description: _getEndDate()),
                        CustomRichText(
                            title: "Price Now: \$",
                            description: product.price.toString()),
                      ],
                    ),
                    10.vGap,

                    // Status or buttons
                    _buildStatusWidget(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
