import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peakmart/app/resources/color_manager.dart';
import 'package:peakmart/app/resources/font_manager.dart';
import 'package:peakmart/app/resources/style_manager.dart';
import 'package:peakmart/app/resources/values_manager.dart';

class OtherLoginMethodsShape extends StatelessWidget {
  const OtherLoginMethodsShape({
    super.key,
    required this.icon,
  });
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: ColorManager.textFormBackground,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: ColorManager.primary, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {},
          splashColor: const Color(0xffFCF3F6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(icon,

                  ),
                  const SizedBox(width: AppSize.s18,),
                  Text(
                    'Google',
                    style: getRegularStyle(
                        fontSize: FontSize.s16,
                      color: ColorManager.grey1
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
