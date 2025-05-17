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
import 'package:peakmart/features/products/domain/entity/top_bidders_entity.dart';
import 'package:peakmart/features/products/presentation/state_m/top_bidders_cubit/top_bidder_cubit.dart';
import 'package:peakmart/features/products/presentation/state_m/top_bidders_cubit/top_bidder_states.dart';
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
  late TopBiddersEntity topBiddersEntity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopBidderCubit, TopBiddersState>(
      builder: (context, state) {
        if (state is TopBiddersLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TopBiddersFailureState) {
          return Center(
            child: Text("Error loading top bidders",
                style: getRegularStyle(fontSize: 18)),
          );
        } else if (state is TopBiddersSuccessState) {
          topBiddersEntity = state.topBidders;

          return SingleChildScrollView(
            child: Column(
              children: [
                ProductDetailsImages(imageUrls: widget.product.imageUrl),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: getBoldStyle(fontSize: FontSize.s24),
                      ),
                      16.vGap,
                      CustomRichText(
                        title: "Description: ",
                        description: widget.product.description,
                      ),
                      8.vGap,
                      CustomRichText(
                        title: "Start Date: ",
                        description: widget.product.startDate,
                      ),
                      8.vGap,
                      CustomRichText(
                        title: "Start Bid: ",
                        description: '${widget.product.price}\$',
                      ),
                      8.vGap,
                      CustomRichText(
                        title: "Current Price: ",
                        description: '${widget.product.price}\$',
                      ),
                      8.vGap,
                      CustomRichText(
                        title: "End Date: ",
                        description: widget.product.endDate,
                      ),
                      8.vGap,
                      Text(
                        '*${topBiddersEntity.totalBidders} Bidding process',
                        style: getBoldStyle(
                          fontSize: FontSize.s16,
                          color: ColorManager.primary,
                        ),
                      ),

                      // Text(
                      //   'Now Bid: \$1000', //* edit if found bidders topBiddersEntity.data[0].amount
                      //   style: getBoldStyle(fontSize: FontSize.s16),
                      // ),

                      Row(
                        children: [
                          Text(
                            '*${topBiddersEntity.totalEnrolled} people enrolled',
                            style: getBoldStyle(
                              fontSize: FontSize.s16,
                              color: ColorManager.primary,
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton(
                              onPressed: () {
                                showDialog<double?>(
                                  context: context,
                                  builder: (context) =>
                                      topBiddersEntity.userStatus == false
                                          ? BidDialog(
                                              higherPrice: widget.product.price,
                                            )
                                          // her if enroll show payment dialog
                                          : BlocProvider(
                                              create: (context) =>
                                                  PaymentCubit(),
                                              child: PaymentDialog(
                                                  higherPrice:
                                                      widget.product.price),
                                            ),
                                ).then((bid) {
                                  if (bid != null) {
                                    log('User entered bid: $bid');
                                    // Handle the bid value
                                  }
                                });
                              },
                              child: Text(topBiddersEntity.userStatus == false
                                  ? 'Bid Now'
                                  : 'Enroll Now'))
                        ],
                      ),
                      16.vGap,
                      TopBiddersSection(
                          topBiddersData: topBiddersEntity.data,
                          isBiddersAvaliable: topBiddersEntity.data.isNotEmpty),
                      10.vGap,
                      BlocProvider(
                        create: (context) => FutureBidsCubit()..getFutureBids(),
                        child: const TitledBidSection<FutureBidsCubit>(
                          title: 'Recommended Bids',
                          isTrending: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink(); // fallback
      },
    );
  }
}

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
    required this.title,
    required this.description,
  });

  final String title, description;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        style: getBoldStyle(
          fontSize: FontSize.s16,
          color: context.isDarkMode ? ColorManager.white : ColorManager.black,
        ),
        children: [
          TextSpan(
              text: description, style: getRegularStyle(fontSize: FontSize.s16))
        ],
      ),
    );
  }
}
