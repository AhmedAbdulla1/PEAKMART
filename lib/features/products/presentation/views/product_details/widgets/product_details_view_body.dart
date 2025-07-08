import 'dart:developer' as log;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/error_ui/toast.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
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
  });

  final ProductEntity product;

  @override
  State<ProductDetailsViewBody> createState() => _ProductDetailsViewBodyState();
}

class _ProductDetailsViewBodyState extends State<ProductDetailsViewBody> {
  @override
  void initState() {
    super.initState();
  }

  bool get _isProductEnded {
    final now = DateTime.now();

    final hasEndedDatePassed = () {
      try {
        if (widget.product.endDate == null) return false;
        final endDate = DateTime.parse(widget.product.endDate!);
        return endDate.isBefore(now);
      } catch (e) {
        return false;
      }
    }();
    log.log(
      ' hasEndedDatePassed: $hasEndedDatePassed',
      name: 'product_end_date_check',
    );
    return hasEndedDatePassed ||
        widget.product.status == 'ended' ||
        widget.product.status == 'canceled';
  }

  bool get _isBiddingAllowed {
    try {
      final startDate = widget.product.startDate != null
          ? DateTime.parse(widget.product.startDate!)
          : DateTime.now();
      final now = DateTime.now();
      return startDate.isBefore(now) || startDate.isAtSameMomentAs(now);
    } catch (e) {
      log.log('Error parsing startDate: $e', name: 'date_parsing');
      return false;
    }
  }

  double _getInitialPrice(TopBiddersEntity? topBiddersEntity) {
    return topBiddersEntity != null && topBiddersEntity.data.isNotEmpty
        ? topBiddersEntity.data[0].bidAmount
        : widget.product.price;
  }

  void _handleDialogResult(BuildContext context, dynamic value) {
    if (value == null || value is! Map<String, dynamic>) return;

    if (value.containsKey('payment_status') &&
        value['payment_status'] == 'success') {
      log.log('Payment successful: $value', name: 'payment');
      context
          .read<ProductCubit>()
          .enrollProduct(
            EnrollRequest(
              productId: widget.product.id.toString(),
              tapId: value['tap_id'].toString(),
              fees: value['fees'].toString(),
            ),
          )
          .then((_) {
        context.read<ProductCubit>().getProductById(id: widget.product.id);
        context
            .read<TopBidderCubit>()
            .getTopBidders(productId: widget.product.id);
      });

      Toast.show("Successfully enrolled in the product!",
          backgroundColor: ColorManager.green);
    } else if (value.containsKey('bid_status') &&
        value['bid_status'] == 'success') {
      log.log('Bid successful: $value', name: 'bid');
      context
          .read<ProductCubit>()
          .bidProduct(
            BidRequest(
              productId: widget.product.id.toString(),
              amount: value['bid'].toString(),
            ),
          )
          .then((_) {
        context.read<ProductCubit>().getProductById(id: widget.product.id);
        context
            .read<TopBidderCubit>()
            .getTopBidders(productId: widget.product.id);
      });

      Toast.show("Bid placed successfully!",
          backgroundColor: ColorManager.green);
    }
  }

  final ValueNotifier<bool> _isFav = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isFav.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = context.isDarkMode;
    final Color primaryColor =
        isDarkMode ? ColorManager.darkModePrimary : ColorManager.primary;
    return BlocBuilder<TopBidderCubit, TopBiddersState>(
      builder: (context, state) {
        final TopBiddersEntity? topBiddersEntity =
            state is TopBiddersSuccessState ? state.topBidders : null;
        log.log("product: ${widget.product.isEnded}");
        log.log("product : ${widget.product.status}");

        final int totalBidders = topBiddersEntity?.totalBidders ?? 0;
        final int totalEnrolled = topBiddersEntity?.totalEnrolled ?? 0;
        final bool userStatus = topBiddersEntity?.userStatus ?? false;
        final double currentPrice = _getInitialPrice(topBiddersEntity);

        return SingleChildScrollView(
          child: Column(
            children: [
              ProductDetailsImages(imageUrls: widget.product.imageUrl),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.c,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.name, // Use the actual product name
                            style: getBoldStyle(fontSize: FontSize.s24),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            // Use ellipsis for overflow
                            softWrap:
                                true, // Ensure wrapping (optional, as it’s true by default)
                          ),
                        ),
                        SizedBox(width: 8),
                        // Replace 8.hGap with SizedBox if not using a custom extension
                        ValueListenableBuilder<bool>(
                          valueListenable: _isFav,
                          builder: (context, isFav, _) => IconButton(
                            onPressed: () {
                              _isFav.value = !isFav;
                            },
                            icon: CircleAvatar(
                              backgroundColor: ColorManager.white,
                              child: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: ColorManager.red,
                              ),
                            ),
                          ),
                        ),
                      ],
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
                      description: '$currentPrice\$',
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
                        if (state is TopBiddersSuccessState)
                          !_isProductEnded
                              ? Visibility(
                                  visible: !userStatus || _isBiddingAllowed,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => userStatus &&
                                                _isBiddingAllowed
                                            ? BidDialog(
                                                higherPrice: currentPrice)
                                            : PaymentDialog(
                                                netPrice: widget.product.price),
                                      ).then((value) =>
                                          _handleDialogResult(context, value));
                                    },
                                    child: Text(
                                      userStatus && _isBiddingAllowed
                                          ? 'Bid Now'
                                          : 'Enroll Now',
                                    ),
                                  ),
                                )
                              : Text(
                                  'Ended',
                                  style: getBoldStyle(
                                    fontSize: FontSize.s20,
                                    color: ColorManager.red,
                                  ),
                                ),
                      ],
                    ),
                    16.vGap,
                    TopBiddersSection(
                      state: state,
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

enum ProductDetailsState { endedProduct, sellerProduct, defaultProduct }
