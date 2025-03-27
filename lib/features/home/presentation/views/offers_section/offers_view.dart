import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/bid_owner/presentation/views/bid_owner_view.dart';
import 'package:peakmart/features/home/domain/entity/content_entity.dart';
import 'package:peakmart/features/home/presentation/state_m/content_cubit/cubit.dart';
import 'package:peakmart/features/home/presentation/state_m/content_cubit/state.dart';

class OffersView extends StatelessWidget {
  OffersView({
    super.key,
    this.imageLink =
        'https://www.picserver.org/highway-signs2/images/for-sale.jpg',
  });

  final String imageLink;
  late ContentData _contentData;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentCubit, ContentState>(builder: (context, state) {
      if (state is ContentError) {
        return Center(
            child: ErrorViewer.showError(
                context: context, error: state.errors, callback: () {}));
      }
      if (state is ContentLoaded) {
        _contentData = state.contentEntity.data.firstWhere(
          (element) => element.sectionName == SectionName.Ads,
        );
        return ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: 200.h, minWidth: double.infinity, minHeight: 150.h),
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.network(
                  _contentData.image["background"],
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: WaitingWidget(),
                    );
                  },
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                top: 50.h,
                right: 20.w,
                left: 20.w,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, BidOwnerView.routeName);
                    },
                    child: Text(
                      AppStrings.enrollNow,
                      style: getBoldStyle(
                          color: ColorManager.white, fontSize: FontSize.s16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
      return const WaitingWidget();
    });
  }
}

// image link https://drive.google.com/file/d/139CyZ6XVjpzR1OQ0GtH_PWup5hIWnXSj/view?usp=sharing
