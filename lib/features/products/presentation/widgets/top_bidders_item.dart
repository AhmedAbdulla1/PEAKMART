import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/features/products/data/models/top_bidder_model.dart';

class TopBidderItem extends StatelessWidget {
  const TopBidderItem({
    super.key,
    required this.topBidderModel,
  });

  final TopBidderModel topBidderModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            "${topBidderModel.number}.",
            style: getBoldStyle(
                fontSize: FontSize.s20, color: ColorManager.primary),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(topBidderModel.photo),
              ),
              title: Row(
                children: [
                  Text(
                    topBidderModel.name,
                    style: getMediumStyle(
                        fontSize: FontSize.s14, color: ColorManager.black),
                  ),
                  const Spacer(),
                  Text(
                    "\$${topBidderModel.amount}",
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
