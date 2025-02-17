import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/features/products/presentation/views/products_view.dart';
import 'package:peakmart/features/products/presentation/views/reordable_list.dart';

import '../../../../core/resources/style_manager.dart';

class ProductDetails extends StatelessWidget {
  static const String routeName = '/product-details';
  final Product product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorManager.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(product.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  RichText(
                    text: TextSpan(
                      text: "Description: ",
                      style: getBoldStyle(
                          fontSize: FontSize.s16, color: ColorManager.black),
                      children: [
                        TextSpan(
                            text:
                                """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat""",
                            style: getRegularStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s16))
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Auction End Date: ${product.endDate}',
                    maxLines: 1,
                  ),

                  Text('Now Bid:\$${product.price}',
                      style: getBoldStyle(
                          fontSize: FontSize.s16, color: ColorManager.black)),
                  Text('*${product.peopleRolledIn} people rolled in',
                      style: getBoldStyle(
                          fontSize: FontSize.s16, color: ColorManager.primary)),
                  ReorderableListWithApi(),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
