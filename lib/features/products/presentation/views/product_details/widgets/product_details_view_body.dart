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
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/home/presentation/state_m/home_cubits/future_bids_cubit.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/titled_bid_section.dart';
import 'package:peakmart/features/payment/presentation/views/payment_dialog.dart';
import 'package:peakmart/features/products/data/models/request/bid_request.dart';
import 'package:peakmart/features/products/data/models/request/enroll_request.dart';
import 'package:peakmart/features/products/domain/entity/top_bidders_entity.dart';
import 'package:peakmart/features/products/presentation/state_m/product_cubit/cubit.dart';
import 'package:peakmart/features/products/presentation/state_m/top_bidders_cubit/top_bidder_cubit.dart';
import 'package:peakmart/features/products/presentation/state_m/top_bidders_cubit/top_bidder_states.dart';
import 'package:peakmart/features/products/presentation/views/product_details/widgets/bid_dialog.dart';
import 'package:peakmart/features/products/presentation/views/product_details/widgets/prodcut_details_images.dart';
import 'package:peakmart/features/products/presentation/widgets/top_bidders.dart';

class ProductDetailsViewBody extends StatefulWidget {
  const ProductDetailsViewBody({
    super.key,
    required this.product,
    // required this.topBiddersData,
  });

  final ProductEntity product;

  // final TopBiddersEntity topBiddersData;
  @override
  State<ProductDetailsViewBody> createState() => _ProductDetailsViewBodyState();
}

class _ProductDetailsViewBodyState extends State<ProductDetailsViewBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = context.isDarkMode;
    final Color primaryColor =
        isDarkMode ? ColorManager.darkModePrimary : ColorManager.primary;
    return BlocBuilder<TopBidderCubit, TopBiddersState>(
      builder: (context, state) {
        final bool isLoading = state is TopBiddersLoadingState;
        final bool isError = state is TopBiddersFailureState;
        final TopBiddersEntity? topBiddersEntity =
            state is TopBiddersSuccessState ? state.topBidders : null;

        final int totalBidders = topBiddersEntity?.totalBidders ?? 0;
        final int totalEnrolled = topBiddersEntity?.totalEnrolled ?? 0;
        final bool userStatus = topBiddersEntity?.userStatus ?? false;

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
                    16.vGap,
                    CustomRichText(
                      title: "Description: ",
                      description: widget.product.description,
                    ),
                    8.vGap,
                    CustomRichText(
                      title: "Start Date: ",
                      description: widget.product.startDate ?? '',
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
                      description: widget.product.endDate ?? '',
                    ),
                    8.vGap,
                    Text(
                      '*$totalBidders Bidding process',
                      style: getBoldStyle(
                        fontSize: FontSize.s16,
                        color: primaryColor,
                      ),
                    ),
                    8.vGap,
                    Row(
                      children: [
                        Text(
                          '*$totalEnrolled people enrolled',
                          style: getBoldStyle(
                            fontSize: FontSize.s16,
                            color: primaryColor,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: isError
                              ? null
                              : () {
                                  double price = topBiddersEntity != null &&
                                          topBiddersEntity.data.isNotEmpty
                                      ? topBiddersEntity.data[0].bidAmount
                                      : widget.product.price;
                                  showDialog(
                                    context: context,
                                    builder: (context) => userStatus
                                        ? BidDialog(
                                            higherPrice: price
                                          )
                                        : PaymentDialog(
                                            netPrice: widget.product.price),
                                  ).then((value) {
                                    if (value != null &&
                                        value is Map<String, dynamic> &&
                                        value.containsKey('payment_status') &&
                                        value['payment_status'] == "success") {
                                      log("value: $value", name: "payment");
                                      context
                                          .read<ProductCubit>()
                                          .enrollProduct(EnrollRequest(
                                              productId:
                                                  widget.product.id.toString(),
                                              tapId: value['tap_id'].toString(),
                                              fees: value['fees'].toString()));
                                    } else if (value != null &&
                                        value is Map<String, dynamic> &&
                                        value.containsKey('bid_status') &&
                                        value['bid_status'] == "success") {
                                      log("value: $value", name: "bid");
                                      context.read<ProductCubit>().bidProduct(
                                          BidRequest(
                                              productId:
                                                  widget.product.id.toString(),
                                              amount: value['bid'].toString()));
                                    }
                                    context
                                        .read<TopBidderCubit>()
                                        .getTopBidders(
                                            productId: widget.product.id);
                                  });
                                },
                          child: Text(userStatus ? 'Bid Now' : 'Enroll Now'),
                        ),
                      ],
                    ),
                    8.vGap,
                    if (isLoading) const WaitingWidget(),
                    16.vGap,
                    TopBiddersSection(
                      topBiddersData: topBiddersEntity?.data ?? [],
                      isError: isError,
                      isBiddersAvaliable:
                          (topBiddersEntity?.data ?? []).isNotEmpty,
                    ),
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
            text: description,
            style: getRegularStyle(fontSize: FontSize.s16),
          ),
        ],
      ),
    );
  }
}
