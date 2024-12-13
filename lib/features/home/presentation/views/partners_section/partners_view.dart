import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/features/home/presentation/views/partners_section/partner_card.dart';

class PartnersView extends StatelessWidget {
  const PartnersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.symmetric(vertical: AppPadding.p20, horizontal: AppPadding.p30),
      child: Column(
        children: [
          Text(
            'Trusted By 500+ Businesses',
            style:
                getBoldStyle(fontSize: FontSize.s16, color: ColorManager.primary),
          ),

          Text(
            'Explore on the world\' s best & largest Bidding marketplace with our beautiful Bidding products. We want to be a part of your smile, success and future growth',
            style: getRegularStyle(fontSize: FontSize.s12, color: ColorManager.grey1),
            textAlign: TextAlign.center,

          ),
          const SizedBox(height: 10,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(child: PartnerCard(imageLink: 'assets/images/partner1.png')),
              Expanded(child: PartnerCard(imageLink: 'assets/images/partner2.png')),
              Expanded(child: PartnerCard(imageLink: 'assets/images/partner3.png')),
              Expanded(child: PartnerCard(imageLink: 'assets/images/partner4.png')),
            ],
          ),
        ],
      ),
    );
  }
}
