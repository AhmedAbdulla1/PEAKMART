import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/features/home/presentation/state_m/home_cubits/future_bids_cubit.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/titled_bid_section.dart';
import 'package:peakmart/features/products/presentation/state_m/top_bidders_cubit/cubit.dart';
import 'package:peakmart/features/products/presentation/views/product_details/prodcut_details_images.dart';
import 'package:peakmart/features/products/presentation/widgets/top_bidders.dart';

import '../../../../../core/resources/style_manager.dart';

class ProductDetails extends StatelessWidget {
  static const String routeName = '/product-details';
  final ProductEntity product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.productDetails,
            style: getBoldStyle(
                fontSize: FontSize.s25, color: ColorManager.white)),
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
            ProductDetailsImages(imageUrls: product.imageUrl),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: getBoldStyle(fontSize: FontSize.s24),
                  ),
                  SizedBox(height: 16.h),
                  RichText(
                    text: TextSpan(
                      text: "Description: ",
                      style: getBoldStyle(
                        fontSize: FontSize.s16,
                      ),
                      children: [
                        TextSpan(
                            text: product.description,
                            style: getRegularStyle(fontSize: FontSize.s16))
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
                        fontSize: FontSize.s16,
                      )),
                  Text('*${product.peopleRolledIn} people rolled in',
                      style: getBoldStyle(
                          fontSize: FontSize.s16, color: ColorManager.primary)),
                  SizedBox(height: 16.h),

                  BlocProvider(
                    create: (context) =>
                        TopBidderCubit()..getTopBidders(productId: product.id),
                    child: TopBidders(
                      productId: product.id,
                    ),
                  ),
                  10.vGap,
                  BlocProvider(
                      create: (context) => FutureBidsCubit()..getFutureBids(),
                      child: const TitledBidSection<FutureBidsCubit>(
                        title: 'Recommended Bids',
                        isTrending: true,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
