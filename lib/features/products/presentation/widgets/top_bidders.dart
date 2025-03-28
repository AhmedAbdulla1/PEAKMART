import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/assets_manager.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:peakmart/features/products/data/models/top_bidder_model.dart';
import 'package:peakmart/features/products/presentation/widgets/top_bidders_item.dart';

class TopBidders extends StatefulWidget {
  const TopBidders({super.key});

  @override
  State<TopBidders> createState() => _TopBiddersState();
}

class _TopBiddersState extends State<TopBidders> {
  // List of top bidders
  List<TopBidderModel> topBidders = [
    TopBidderModel(
        name: "Ahmed Gad",
        photo: ImageAssets.person1,
        amount: 2000,
        number: "1"),
    TopBidderModel(
        name: "Samir Mohamed",
        photo: ImageAssets.person2,
        amount: 1700,
        number: "2"),
    TopBidderModel(
        name: "Mostafa Khaled",
        photo: ImageAssets.person3,
        amount: 1300,
        number: "3"),
  ];

  // Function to reorder items
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = topBidders.removeAt(oldIndex);
      topBidders.insert(newIndex, item);
    });
  }

  // Function to reorder items randomly
  void _reorderRandomly() {
    setState(() {
      topBidders.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.isDarkMode ? Colors.black : Colors.white,
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
            // ReorderableListView
            SizedBox(
              height: topBidders.length * 70, // Adjust height dynamically
              child: ReorderableListView.builder(
                onReorder: _onReorder,
                itemCount: topBidders.length,
                itemBuilder: (context, index) {
                  final bidder = topBidders[index];
                  return TopBidderItem(
                    key: ValueKey(bidder), // Unique key for each item
                    topBidderModel: bidder,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
