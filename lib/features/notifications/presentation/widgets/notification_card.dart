import 'package:Bid_Mart/features/notifications/presentation/state_m/notification_cubit.dart';
import 'package:Bid_Mart/features/products/presentation/views/product_details/product_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/extentions.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:Bid_Mart/features/notifications/domain/notification_enitity.dart';
import 'package:Bid_Mart/features/notifications/presentation/view/notifications_view_body.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.item,
    required this.isSeen,
  });

  final NotificationEntity item;
  final bool isSeen;

  @override
  Widget build(BuildContext context) {
    final textColor = isSeen
        ? (context.isDarkMode ? Colors.grey[350] : Colors.grey[800])
        : Theme.of(context).textTheme.bodyMedium?.color;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context,item.routeName, arguments: item.arg);
        if (!isSeen) {
          context.read<NotificationCubit>().markAsRead(item.id);
        }
      },
      child: Material(
        elevation: isSeen ? 1 : 4,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSeen
                ? (context.isDarkMode
                    ? ColorManager.blueDarker.withValues(alpha: .1)
                    : ColorManager.grey3)
                : context.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSeen
                  ? ColorManager.white.withValues(alpha:0.5)
                  : context.primaryColor.withOpacity(0.7),
              width: 1.5,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIcon(context),
              12.hGap,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: getBoldStyle(fontSize: FontSize.s16).copyWith(
                        color: textColor,
                      ),
                    ),
                    6.vGap,
                    Text(
                      item.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: getRegularStyle(
                        fontSize: FontSize.s14,
                        color: textColor,
                      ),
                    ),
                    10.vGap,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatTimeAgo(item.createdAt),
                          style: getRegularStyle(
                            fontSize: FontSize.s14,
                            color: context.isDarkMode
                                ? Colors.grey
                                : ColorManager.grey1,
                          ),
                        ),
                        if (isSeen)
                          Icon(
                            Icons.done_all,
                            size: 16,
                            color: context.primaryColor,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              if (!isSeen)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: context.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    final bgColor = isSeen
        ? (context.isDarkMode ? ColorManager.darkGrey : ColorManager.greyColor)
        : context.primaryColor.withOpacity(0.2);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.string(
        (item.icon != null && item.icon!.isNotEmpty) ? item.icon! : _defaultSvg,
        colorFilter: ColorFilter.mode(
          isSeen ? ColorManager.white : context.primaryColor,
          BlendMode.srcIn,
        ),
        height: 24,
        width: 24,
      ),
    );
  }
}

const String _defaultSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="100" height="100" viewBox="0 0 30 30">
<path d="M 15 3 C 13.9 3 13 3.9 13 5 L 13 5.265625 C 9.5610846 6.1606069 7 9.2910435 7 13 L 7 15.400391 C 7 17.000391 6.6996094 18.5 6.0996094 20 L 23.900391 20 C 23.300391 18.5 23 17.000391 23 15.400391 L 23 13 C 23 9.2910435 20.438915 6.1606069 17 5.265625 L 17 5 C 17 3.9 16.1 3 15 3 z M 5 22 A 1.0001 1.0001 0 1 0 5 24 L 12.173828 24 C 12.068319 24.312339 12 24.644428 12 25 C 12 26.7 13.3 28 15 28 C 16.7 28 18 26.7 18 25 C 18 24.644428 17.931681 24.312339 17.826172 24 L 25 24 A 1.0001 1.0001 0 1 0 25 22 L 5 22 z"></path>
</svg>
''';
