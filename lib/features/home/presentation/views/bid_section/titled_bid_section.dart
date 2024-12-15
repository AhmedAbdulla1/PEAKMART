import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/bid_card_model.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/bid_page_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TitledBidSection extends StatelessWidget {
  const TitledBidSection({super.key, required this.title,required this.bids, this.isEnded=false});
  final String title;
  final List<BidCardModel> bids;
  final bool isEnded ;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style:
              getBoldStyle(fontSize: FontSize.s28, color: ColorManager.primary),
        ),
        const SizedBox(
          height:AppSize.s12,
        ),
         SizedBox(
           height: 370.h,
             child: BidPageView(bidCards: bids,isEnded: isEnded,)),
      ],
    );
  }
}
