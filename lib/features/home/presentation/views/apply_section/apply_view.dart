import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/features/products/presentation/views/privacy_and_policy_view.dart';

class ApplyView extends StatelessWidget {
  const ApplyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 30.w,
      ),
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/apply.png'), fit: BoxFit.cover),
      ),
      child: Column(
        children: [
          Text('Unlock Maximum Value',
              style: getBoldStyle(
                  fontSize: FontSize.s16, color: ColorManager.lightPrimary)),
          Text(
            'Showcase your item and watch the bids drive up the price.Your chance to secure the highest profit is here!',
            style: getRegularStyle(
              fontSize: FontSize.s12,
              color: ColorManager.white,
            ),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, PrivacyAndPolicyView.routeName);
            },
            child: const Text('Apply Now'),
          ),
        ],
      ),
    );
  }
}
