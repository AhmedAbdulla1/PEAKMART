import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/features/products/domain/entity/top_bidders_entity.dart';

class TopBidderItem extends StatelessWidget {
  const TopBidderItem({
    super.key,
    required this.topBiddersData,
    required this.rank,
    this.isFaded = false,
  });

  final TopBiddersData topBiddersData;
  final int rank;
  final bool isFaded;

  @override
  Widget build(BuildContext context) {
    final baseColor = isFaded
        ? ColorManager.greyColor.withOpacity(0.3)
        : context.colorScheme.surface;

    return Card(
      color: baseColor,
      elevation: isFaded ? 0 : 2,
      child: Padding(
        key: ValueKey(topBiddersData.bidderId),
        padding: const EdgeInsets.symmetric(
            vertical: AppPadding.p8, horizontal: AppPadding.p10),
        child: Row(
          children: [
            Text(
              rank.toString(),
              style: getBoldStyle(
                  fontSize: FontSize.s20,
                  color:
                      isFaded ? ColorManager.greyColor : ColorManager.primary),
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(topBiddersData.userPhoto),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      topBiddersData.userName,
                      style: getMediumStyle(
                        fontSize: FontSize.s14,
                      ).copyWith(
                        color: isFaded ? Colors.grey : null,
                      ),
                    ),
                    Text(
                      "\$${topBiddersData.bidAmount}",
                      style: getBoldStyle(
                        fontSize: FontSize.s16,
                        color: isFaded ? Colors.grey : ColorManager.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
