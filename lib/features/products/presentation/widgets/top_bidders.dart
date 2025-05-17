import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:peakmart/features/products/domain/entity/top_bidders_entity.dart';
import 'package:peakmart/features/products/presentation/widgets/top_bidders_item.dart';

class TopBiddersSection extends StatefulWidget {
  const TopBiddersSection(
      {super.key,
      required this.topBiddersData,
      required this.isBiddersAvaliable, required this.isError});
  final List<TopBiddersData> topBiddersData;
  final bool isBiddersAvaliable,isError;
  @override
  State<TopBiddersSection> createState() => _TopBiddersSectionState();
}

class _TopBiddersSectionState extends State<TopBiddersSection> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colorScheme.surface,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Text(
                "Top Bidders",
                style: getBoldStyle(fontSize: FontSize.s24),
              ),
            ),
            10.vGap,
           widget.isBiddersAvaliable
                ? SizedBox(
                    height: widget.topBiddersData.length * 80,
                    child: AnimatedReorderableListView(
                      longPressDraggable: false,
                      items: widget.topBiddersData,
                      itemBuilder: (context, index) {
                        final bidder = widget.topBiddersData[index];
                        return TopBidderItem(
                          key: ValueKey(bidder.bidderId),
                          topBiddersData: bidder,
                          rank: index + 1,
                        );
                      },
                      enterTransition: [
                        SlideInDown(duration: const Duration(seconds: 2))
                      ],
                      exitTransition: [
                        SlideInUp(duration: const Duration(seconds: 2))
                      ],
                      insertDuration: const Duration(milliseconds: 500),
                      removeDuration: const Duration(milliseconds: 500),
                      onReorder: (int oldIndex, int newIndex) {
                        setState(() {
                          final item = widget.topBiddersData.removeAt(oldIndex);
                          widget.topBiddersData.insert(newIndex, item);
                        });
                      },
                      isSameItem: (a, b) => a.bidderId == b.bidderId,
                    ),
                  )
                : Text(
                  widget.isError? "Failed to load bidding data": "There are no bidders yet",
                    style:
                        getRegularStyle(fontSize: 18, color: ColorManager.red),
                  )
          ],
        ),
      ),
    );
  }
}
