import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/app/resources/color_manager.dart';
import 'package:peakmart/app/resources/font_manager.dart';
import 'package:peakmart/app/resources/style_manager.dart';

class OfferSView extends StatelessWidget {
  const OfferSView({
    super.key,
    this.imageLink =
        'https://www.picserver.org/highway-signs2/images/for-sale.jpg',
  });

  final String imageLink;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:  BoxConstraints(maxHeight: 220.h,minWidth: double.infinity,minHeight: 170.h),
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.network(
              imageLink,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              },
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: 30.h,
            right: 20.w,
            left: 20.w,
            child: Center(
              child: ElevatedButton(
                onPressed: () {},
                child:  Text(
                  'Enroll Now',
                  style: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// image link https://drive.google.com/file/d/139CyZ6XVjpzR1OQ0GtH_PWup5hIWnXSj/view?usp=sharing
