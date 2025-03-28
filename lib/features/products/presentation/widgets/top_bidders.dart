import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:peakmart/features/products/presentation/state_m/top_bidders_cubit/cubit.dart';
import 'package:peakmart/features/products/presentation/state_m/top_bidders_cubit/states.dart';
import 'package:peakmart/features/products/presentation/widgets/top_bidders_item.dart';

class TopBidders extends StatefulWidget {
  const TopBidders({super.key});

  @override
  State<TopBidders> createState() => _TopBiddersState();
}

class _TopBiddersState extends State<TopBidders> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TopBidderCubit>(context).getTopBidders(productId: 1);
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final cubit = context.read<TopBidderCubit>();
      final item = cubit.topBidders.removeAt(oldIndex);
      cubit.topBidders.insert(newIndex, item);
    });
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
              child: Text(AppStrings.topBidders,
                  style: getBoldStyle(
                      fontSize: FontSize.s20, color: ColorManager.primary)),
            ),
            const SizedBox(height: 10),
            BlocBuilder<TopBidderCubit, TopBiddersState>(
              builder: (context, state) {
                if (state is TopBiddersLoadingState) {
                  return const CircularProgressIndicator();
                } else if (state is TopBiddersFailureState) {
                  return Text("Error loading top bidders",
                      style: getBoldStyle(fontSize: FontSize.s20));
                } else if (state is TopBiddersSuccessState) {
                  final topBidders = state.topBidders;
                  if (topBidders.isEmpty) {
                    return Text(
                      "There is no bidders yet",
                      style: getBoldStyle(fontSize: FontSize.s20),
                    );
                  }
                  return SizedBox(
                    height: topBidders.length * 70,
                    child: ReorderableListView.builder(
                      onReorder: _onReorder,
                      itemCount: topBidders.length,
                      itemBuilder: (context, index) {
                        final bidder = topBidders[index];
                        return TopBidderItem(
                          key: ValueKey(bidder),
                          topBiddersData: bidder,
                        );
                      },
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
