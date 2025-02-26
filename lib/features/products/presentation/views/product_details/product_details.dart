import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/features/products/data/models/product_model.dart';
import 'package:peakmart/features/products/presentation/views/product_details/prodcut_details_images.dart';
import 'package:peakmart/features/products/presentation/views/products_view.dart';
import 'package:peakmart/features/products/presentation/widgets/top_bidders.dart';

import '../../../../../core/resources/style_manager.dart';

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
            ProductDetailsImages(imageUrls: [
              // 'https://deelay.me/5000/https://picsum.photos/1200/800', // 5-second delay
              'https://picsum.photos/800/600', // Fast-loading image
              'https://picsum.photos/1900/1900', // Large image
              "https://imgs.search.brave.com/eAK2XfPpoLbnXT3MZrHRkIGGQR0NtlSJ9PTiW48VDKU/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzA1LzIxLzAyLzM0/LzM2MF9GXzUyMTAy/MzQ2MF94WXdpT2kx/N1Bub25ueEM1VzQz/U2xqcVdhcUJhUjh3/Zy5qcGc",
              'https://imgs.search.brave.com/4jNLJmyJiU7u36PRgvcwzoOxSKzIj6a_vX20fcIHH0Q/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvNTEz/NDM5MzQxL3Bob3Rv/L3BvcnRyYWl0LW9m/LWVudGh1c2lhc3Rp/Yy1idXNpbmVzcy1w/ZW9wbGUtaW4tY2ly/Y2xlLmpwZz9zPTYx/Mng2MTImdz0wJms9/MjAmYz1veHdzcThX/R0ZUMGl4bVNvam50/WUJFWnFpZm5lNFA3/RGxxT1diWENxV1Vr/PQ',
              'https://imgs.search.brave.com/w2HND3H2u2ORdvuYc96qSZUj_BxcJM2mKSEhQ2E_04I/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzA3LzQxLzcxLzkz/LzM2MF9GXzc0MTcx/OTM5NF9DOUJQM1li/aVhTSjdXc3BTREx0/S2RZeFpLS1dsZjBK/ei5qcGc',
              "https://imgs.search.brave.com/HnucNzNI7AHQT2y_JJQkSupdYAMfwkceCfGMy7P0LAI/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/aXN0b2NrcGhvdG8u/Y29tL3Jlc291cmNl/cy9pbWFnZXMvUGhv/dG9GVExQL1AzLWlT/dG9jay0yMTY0MTU4/MTAzLmpwZw",
              'https://imgs.search.brave.com/4jNLJmyJiU7u36PRgvcwzoOxSKzIj6a_vX20fcIHH0Q/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvNTEz/NDM5MzQxL3Bob3Rv/L3BvcnRyYWl0LW9m/LWVudGh1c2lhc3Rp/Yy1idXNpbmVzcy1w/ZW9wbGUtaW4tY2ly/Y2xlLmpwZz9zPTYx/Mng2MTImdz0wJms9/MjAmYz1veHdzcThX/R0ZUMGl4bVNvam50/WUJFWnFpZm5lNFA3/RGxxT1diWENxV1Vr/PQ',
              'https://imgs.search.brave.com/w2HND3H2u2ORdvuYc96qSZUj_BxcJM2mKSEhQ2E_04I/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzA3LzQxLzcxLzkz/LzM2MF9GXzc0MTcx/OTM5NF9DOUJQM1li/aVhTSjdXc3BTREx0/S2RZeFpLS1dsZjBK/ei5qcGc',
                ]),
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
                  // ReorderableListWithApi(),
                  SizedBox(height: 16.h),

                  const TopBidders()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
