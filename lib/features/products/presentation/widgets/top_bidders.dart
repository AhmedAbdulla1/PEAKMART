import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:flutter/material.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/extentions.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:Bid_Mart/core/widgets/waiting_widget.dart';
import 'package:Bid_Mart/features/products/domain/entity/top_bidders_entity.dart';
import 'package:Bid_Mart/features/products/presentation/state_m/top_bidders_cubit/top_bidder_states.dart';
import 'package:Bid_Mart/features/products/presentation/widgets/top_bidders_item.dart';

class TopBiddersSection extends StatefulWidget {
  const TopBiddersSection({
    super.key,
    required this.state,
  });

  final TopBiddersState state;

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
            if (widget.state is TopBiddersLoadingState)
              const SizedBox(
                height: 200,
                child: Center(child: WaitingWidget()),
              )
            else if (widget.state is TopBiddersFailureState)
              Text(
                "Failed to load bidding data",
                style: getRegularStyle(fontSize: 18, color: ColorManager.red),
                textAlign: TextAlign.center,
              )
            else if (widget.state is TopBiddersSuccessState)
              _buildBiddersList(widget.state as TopBiddersSuccessState)
            else
              Text(
                "Loading top bidders...",
                style: getRegularStyle(fontSize: 18, color: ColorManager.grey),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBiddersList(TopBiddersSuccessState successState) {
    final List<TopBiddersData> topBiddersData = successState.topBidders.data;
    final bool isBiddersAvaliable = topBiddersData.isNotEmpty;

    if (!isBiddersAvaliable) {
      return Text(
        "There are no bidders yet",
        style: getRegularStyle(fontSize: 18, color: ColorManager.red),
        textAlign: TextAlign.center,
      );
    }

    return SizedBox(
      height: (topBiddersData.length.clamp(0, 4)) * 80,
      child: AnimatedReorderableListView(
        longPressDraggable: false,
        items: topBiddersData,
        itemBuilder: (context, index) {
          if (index > 3) return const SizedBox.shrink();

          final bidder = topBiddersData[index];

          return TopBidderItem(
            key: ValueKey(bidder.bidderId),
            topBiddersData: bidder,
            rank: index + 1,
            isFaded: index == 3,
          );
        },
        enterTransition: [
          SlideInDown(duration: const Duration(milliseconds: 500))
        ],
        exitTransition: [
          SlideInUp(duration: const Duration(milliseconds: 500))
        ],
        insertDuration: const Duration(milliseconds: 500),
        removeDuration: const Duration(milliseconds: 500),
        onReorder: (int oldIndex, int newIndex) {},
        isSameItem: (a, b) => a.bidderId == b.bidderId,
      ),
    );
  }
}
