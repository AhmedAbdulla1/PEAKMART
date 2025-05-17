import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:peakmart/features/home/presentation/state_m/home_cubits/future_bids_cubit.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/titled_bid_section.dart';
import 'package:peakmart/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:peakmart/features/payment/presentation/views/bid_dialog.dart';
import 'package:peakmart/features/products/presentation/state_m/top_bidders_cubit/top_bidder_cubit.dart';
import 'package:peakmart/features/products/presentation/views/product_details/widgets/bid_dialog.dart';
import 'package:peakmart/features/products/presentation/views/product_details/widgets/prodcut_details_images.dart';
import 'package:peakmart/features/products/presentation/widgets/top_bidders.dart';

class ProductDetailsViewBody extends StatefulWidget {
  const ProductDetailsViewBody({
    super.key,
    required this.product,
  });

  final ProductEntity product;

  @override
  State<ProductDetailsViewBody> createState() => _ProductDetailsViewBodyState();
}

class _ProductDetailsViewBodyState extends State<ProductDetailsViewBody> {
  int nowBid = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductDetailsImages(imageUrls: widget.product.imageUrl),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: getBoldStyle(fontSize: FontSize.s24),
                ),
                SizedBox(height: 16.h),
                RichText(
                  text: TextSpan(
                    text: "Description: ",
                    style: getBoldStyle(
                      fontSize: FontSize.s16,
                      color: context.isDarkMode
                          ? ColorManager.white
                          : ColorManager.black,
                    ),
                    children: [
                      TextSpan(
                          text: widget.product.description,
                          style: getRegularStyle(fontSize: FontSize.s16))
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Auction End Date: ${widget.product.endDate}',
                  maxLines: 1,
                ),
                Text('Now Bid: \$$nowBid',
                    style: getBoldStyle(
                      fontSize: FontSize.s16,
                    )),
                Row(
                  children: [
                    Text('*${widget.product.peopleRolledIn} people rolled in',
                        style: getBoldStyle(
                            fontSize: FontSize.s16,
                            color: ColorManager.primary)),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          showDialog<double?>(
                            context: context,
                            builder: (context) => false
                                //her if bid
                                ? BidDialog(
                                    higherPrice: widget.product.price,
                                  )
                            // her if enroll show payment dialog
                                : BlocProvider
                              (
                              create:    (context)=>PaymentCubit(),
                                  child: PaymentDialog(
                                      higherPrice: widget.product.price),
                                ),
                          ).then((bid) {
                            if (bid != null) {
                              log('User entered bid: $bid');
                              // Handle the bid value
                            }
                          });
                        },
                        child: const Text(false ? 'Bid Now' : 'Enroll Now'))
                  ],
                ),
                SizedBox(height: 16.h),
                BlocProvider(
                  create: (context) => TopBidderCubit()
                    ..getTopBidders(productId: widget.product.id),
                  child: TopBidders(
                    productId: widget.product.id,
                    returnNowBid: (int nowBidAmount) {
                      nowBid = nowBidAmount;
                    },
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
    );
  }
}
