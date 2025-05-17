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
                      Text(
                        'Now Bid: \$1000', //* edit if found bidders topBiddersEntity.data[0].amount
                        style: getBoldStyle(fontSize: FontSize.s16),
                      ),
                      Row(
                        children: [
                          Text(
                            '*${topBiddersEntity.totalEnrolled} people rolled in',
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
                                builder: (context) => BidDialog(
                                  higherPrice: widget.product.price,
                                ),
                              ).then((bid) {
                                if (bid != null) {
                                  log('User entered bid: $bid');
                                  // Handle the bid value here
                                }
                              });
                            },
                            child: const Text('Roll Now'),
                          ),
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
