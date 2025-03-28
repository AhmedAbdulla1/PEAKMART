import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/features/products/domain/entity/top_bidders_entity.dart';

class TopBidderItem extends StatelessWidget {
  const TopBidderItem({
    super.key,
    required this.topBiddersData,
    required this.rank,
  });

  final TopBiddersData topBiddersData;
  final int rank;
  @override
  Widget build(BuildContext context) {
    return Padding(
      key: ValueKey(topBiddersData.bidderId),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            rank.toString(),
            style: getBoldStyle(
                fontSize: FontSize.s20, color: ColorManager.primary),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(topBiddersData.userPhoto), // *edit by network image in future
              ),
              title: Row(
                children: [
                  Text(
                    topBiddersData.userName,
                    style: getMediumStyle(fontSize: FontSize.s14),
                  ),
                  const Spacer(),
                  Text(
                    "\$${topBiddersData.bidAmount}",
                    style: getBoldStyle(
                        fontSize: FontSize.s16, color: ColorManager.primary),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
