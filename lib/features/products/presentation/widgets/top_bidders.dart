import 'dart:developer';

import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:peakmart/features/products/presentation/state_m/top_bidders_cubit/cubit.dart';
import 'package:peakmart/features/products/presentation/state_m/top_bidders_cubit/states.dart';
import 'package:peakmart/features/products/presentation/widgets/top_bidders_item.dart';

class TopBidders extends StatefulWidget {
  const TopBidders({super.key, required this.productId});
  final int productId;

  @override
  State<TopBidders> createState() => _TopBiddersState();
}

class _TopBiddersState extends State<TopBidders> {
  @override
  void initState() {
    super.initState();
    log("productId: ${widget.productId}");
    BlocProvider.of<TopBidderCubit>(context).startAutoRefresh(widget.productId);
  }

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
            BlocBuilder<TopBidderCubit, TopBiddersState>(
              builder: (context, state) {
                if (state is TopBiddersLoadingState) {
                  return const CircularProgressIndicator();
                } else if (state is TopBiddersFailureState) {
                  return const Text("Error loading top bidders",
                      style: TextStyle(color: Colors.white));
                } else if (state is TopBiddersSuccessState) {
                  final topBidders = state.topBidders;
                  if (topBidders.isEmpty) {
                    return const Text("There are no bidders yet",
                        style: TextStyle(color: Colors.white));
                  }
                  return SizedBox(
                    height: topBidders.length * 70,
                    child: AnimatedReorderableListView(
                      items: topBidders,
                      itemBuilder: (context, index) {
                        final bidder = topBidders[index];
                        return TopBidderItem(
                          key: ValueKey(bidder.bidderId),
                          topBiddersData: bidder,
                          rank: index + 1, // إضافة الرقم بجانب المزايد
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
                          final item = topBidders.removeAt(oldIndex);
                          topBidders.insert(newIndex, item);
                        });
                      },
                      isSameItem: (a, b) => a.bidderId == b.bidderId,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
