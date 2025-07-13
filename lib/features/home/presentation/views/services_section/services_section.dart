import 'package:flutter/material.dart';
import 'package:Bid_Mart/features/home/presentation/views/services_section/item_service.dart';
import 'package:Bid_Mart/features/home/presentation/views/services_section/item_service_model.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});
  static const List<ItemServiceModel> servicesItems = [
    ItemServiceModel(
        title: "Product delivery",
        description:
            "You can choose to pay easily via Bid_Mart’s digital wallet, credit cards, in installments or by cash.",
        image: "assets/images/Credit_Card.png"),
    ItemServiceModel(
        title: "Auction or direct sale",
        description:
            "On Bid_Mart you can choose to sell your items through an auction, a direct sale with a set price, or through a hybrid of the two forms",
        image: "assets/images/court_hmer.png"),
    ItemServiceModel(
        title: "100% Secure",
        description:
            "With PeakMark, You’re subjected to zero risk of getting mugged, harassed, or threatened in any way.",
        image: "assets/images/security.png"),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: servicesItems.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(start: 12.0),
            child: ItemService(
              itemServiceModel: servicesItems[index],
            ),
          );
        },
      ),
    );
  }
}
