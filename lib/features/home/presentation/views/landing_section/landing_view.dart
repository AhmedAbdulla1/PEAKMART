import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/resources/assets_manager.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/auth/presentation/state_mang/signup_for_bid/cubit.dart';
import 'package:peakmart/features/auth/presentation/views/signup_for_bid/view.dart';
import 'package:peakmart/features/home/domain/entity/content_entity.dart';
import 'package:peakmart/features/home/presentation/state_m/content_cubit/cubit.dart';
import 'package:peakmart/features/home/presentation/state_m/content_cubit/state.dart';

class LandingView extends StatelessWidget {
  LandingView({super.key});

  final String buttonText = "Join Now";
  ContentData? _contentData;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentCubit, ContentState>(builder: (context, state) {
      if (state is ContentError) {
        return Center(
            child: ErrorViewer.showError(
                context: context, error: state.errors, callback: () {}));
      }
      if (state is ContentLoading || state is ContentInitial) {
        return const Center(child: WaitingWidget());
      }
      if (state is ContentLoaded) {
        _contentData = state.contentEntity.data.firstWhere(
          (element) => element.sectionName == SectionName.Cover,
        );
        return Card(
          margin: const EdgeInsets.all(AppPadding.p20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: Container(
            padding: const EdgeInsetsDirectional.only(
              start: AppPadding.p30,
              top: AppPadding.p20,
              bottom: AppPadding.p14,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(_contentData!.image["background"]),
                    fit: BoxFit.cover)),
            child: Stack(
              children: [
                Positioned(
                    right: 0,
                    child: Image.network(_contentData!.image["image"],
                        height: 125.w)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 240,

                      child: Text(
                        _contentData!.content,
                        softWrap: true,
                        style: getBoldStyle(
                            fontSize: FontSize.s17, color: ColorManager.primary),
                      ),
                    ),

                    SizedBox(height: AppSize.s40.h),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                      create: (context) => SignUpForBidCubit(),
                                      child: SignUpForBidView(),
                                    )));
                      },
                      child: Text(
                        buttonText,
                        style: getBoldStyle(
                            fontSize: FontSize.s17, color: ColorManager.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
      return const Center(child: WaitingWidget());
    });
  }
}
