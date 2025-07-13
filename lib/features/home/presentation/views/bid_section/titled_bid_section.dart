import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Bid_Mart/core/entities/prodcut_entity.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:Bid_Mart/core/resources/values_manager.dart';
import 'package:Bid_Mart/features/home/presentation/state_m/home_cubits/states.dart';
import 'package:Bid_Mart/features/home/presentation/views/bid_section/widgets/bids_slider.dart';
import 'package:Bid_Mart/features/home/presentation/views/bid_section/widgets/custom_bid_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

final ProductEntity fakeProduct = ProductEntity(
    id: 1,
    name: 'Product Name',
    imageUrl: const [],
    description: 'Product Description',
    endDate: DateTime.now().toString(),
    peopleRolledIn: 0,
    price: 0,
    isEnded: false,
    startDate: "9999",
    status: '0',
    startingPrice: '0',
    expectedPrice: '0',
    periodOfBid: 0,
    catId: 0,
    userId: 0,
    createdAt: DateTime.now().toString());

class TitledBidSection<C extends Cubit<BidsState>> extends StatelessWidget {
  const TitledBidSection({
    super.key,
    required this.title,
    this.isEnded = false,
    this.isFuture = false,
    this.isTrending = false,
  });

  final String title;
  final bool isEnded, isFuture, isTrending;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, BidsState>(
      builder: (context, state) {
        List<ProductEntity> products = [];

        if (state is BidWorkNowSuccessState) {
          products = state.bidWorkNowData;
        }
        if (state is EndedBidsSuccessState) {
          products = state.endedBidsData;
        }
        if (state is FutureBidsSuccessState) {
          products = state.futureBidsData;
        }
        if (state is TrendingBidsSuccessState) {
          products = state.trendingBidsData;
        }
        if (state is BidsLoadingState) {
          return Skeletonizer(
            child: SizedBox(
              height: 370.h,
              width: 270.w,
              child: CustomBidItem(
                bidItem: fakeProduct,
              ),
            ),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: getBoldStyle(
                fontSize: FontSize.s28,
                color: context.isDarkMode
                    ? ColorManager.darkModePrimary
                    : ColorManager.primary,
              ),
            ),
            const SizedBox(height: AppSize.s12),
            SizedBox(
              height: 370.h,
              child: BidsSlider(
                isFuture: isFuture,
                isTrending: isTrending,
                isEnded: isEnded,
                productEntity: products,
              ),
            ),
          ],
        );
      },
    );
  }
}
