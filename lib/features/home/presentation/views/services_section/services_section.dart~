import 'package:flutter/material.dart';
import 'package:peakmart/features/home/presentation/views/services_section/item_service.dart';
import 'package:peakmart/features/home/presentation/views/services_section/item_service_model.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return const  Padding(
            padding: EdgeInsetsDirectional.only(start: 12.0),
            child: ItemService(
              itemServiceModel: ItemServiceModel(
                title: 'Product delivery',
                description:
                    'You can choose to pay easily via PeakMart’s digital wallet, credit cards, in installments or by cash.',
                image: 'assets/images/Credit_Card.png',
              ),
            ),
          );
        },
      ),
    );
  }
}
