import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/home/domain/entity/content_entity.dart';
import 'package:peakmart/features/home/presentation/state_m/content_cubit/cubit.dart';
import 'package:peakmart/features/home/presentation/state_m/content_cubit/state.dart';
import 'package:peakmart/features/products/presentation/views/privacy_and_policy_view.dart';

class ApplyView extends StatelessWidget {
  ApplyView({super.key});

  late ContentData _contentData;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentCubit, ContentState>(builder: (context, state) {
      if (state is ContentError) {
        return SizedBox();
          //
          // ErrorViewer.showError(
          //   error: state.errors, context: context, callback: () {});
      }
      if (state is ContentLoaded) {
        _contentData = state.contentEntity.data
            .firstWhere((element) => element.sectionName == SectionName.Apply);
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 30.w,
          ),
          width: double.infinity,
          decoration:  BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(_contentData.image["background"],),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Text(_contentData.content ,
                  style: getBoldStyle(
                      fontSize: FontSize.s16,
                      color: ColorManager.lightPrimary)),
              Text(
                _contentData.subTitle??"",
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
      return const WaitingWidget();
    });
  }
}
