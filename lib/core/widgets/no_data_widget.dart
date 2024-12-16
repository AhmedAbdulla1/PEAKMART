import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peakmart/core/constants/app/app_constants.dart';
import 'package:peakmart/core/resources/color_manager.dart';



class BaseErrorWidget extends StatefulWidget {
  final GestureTapCallback? onTap;
  final String? title;
  final String? subtitle;
  final Widget? icon;
  final Widget? button;

  const BaseErrorWidget({
    super.key,
    this.onTap,
    this.title,
    this.subtitle,
    this.icon,
    this.button,
  });

  @override
  State<BaseErrorWidget> createState() => _BaseErrorWidgetState();
}

class _BaseErrorWidgetState extends State<BaseErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1.0.sw,
        child: InkWell(
          highlightColor: ColorManager.black,
          onTap: widget.onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(0.01),
                child: widget.icon,
              ),
              Text(
                widget.title ?? '',
                style:  TextStyle(
                  fontSize: 20,
                  color: ColorManager.primary,
                ),
                textAlign: TextAlign.center,
                //       )AppTheme.headline3
              ),
              // Text(
              //   widget.subtitle ?? "",
              //   style: TextStyle(
              //     color: AppColors.primary[100],
              //     fontSize: 20,
              //   ),
              //   //AppTheme.headline4,
              //   textAlign: TextAlign.center,
              // ),
              widget.button ?? Container()
            ],
          ),
        ),
      ),
    );
  }
}

class NoDataWidget extends StatelessWidget {
  final String? message;
  final NoData? noData;
  const NoDataWidget({super.key, this.message, this.noData});
  @override
  Widget build(BuildContext context) {
    return BaseErrorWidget(
      onTap: null,
      title: noData?.message ?? message ,
      subtitle: '',
      icon: SvgPicture.asset(
        noData?.image ?? AppConstants.no_data,
        height: 0.25.sh,
      ),
    );
  }
}

class AppAssets {
}
class NoData{
  final String? image;
  final String? message;

  NoData({this.image, this.message});
}