import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/features/bid_owner/data/models/request/add_product_request.dart';

import '../../../../core/resources/style_manager.dart';

class AddProductDetails extends StatelessWidget {
  static const String routeName = '/add_product_details';
  final AddProductRequest addProductRequest;

  const AddProductDetails({super.key, required this.addProductRequest});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250.h,
              decoration: const BoxDecoration(
                image: const DecorationImage(
                  image: const AssetImage('assets/images/card.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: SizedBox(
                      height: 80.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image.asset(
                                'assets/images/card.png',
                                fit: BoxFit.cover,
                                width: 80.w,
                                height: 80.h,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    addProductRequest.name,
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
                          fontSize: FontSize.s24, color: ColorManager.black),
                      children: [
                        TextSpan(
                            text: addProductRequest.description,
                            style: getRegularStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s16))
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Auction Start Date: ${addProductRequest.startDate}',
                    maxLines: 1,
                    style: getBoldStyle(
                        fontSize: FontSize.s16, color: ColorManager.black),
                  ),
                  SizedBox(height: 16.h),
                  Text('Now Bid: \$${addProductRequest.startingPrice}',
                      style: getBoldStyle(
                          fontSize: FontSize.s16, color: ColorManager.black)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
