import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/assets_manager.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/features/products/data/models/top_bidder_model.dart';
import 'package:peakmart/features/products/presentation/widgets/top_bidders_item.dart';

class TopBidders extends StatelessWidget {
  const TopBidders({super.key});

  static List<TopBidderModel> getTopBidders = [
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

  @override
  Widget build(BuildContext context) {
    return Card(
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
            SizedBox(
               height: getTopBidders.length * 70,
              child: ListView.builder(
                itemCount: getTopBidders.length,
                itemBuilder: (context, index) {
                  return TopBidderItem(topBidderModel: getTopBidders[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
