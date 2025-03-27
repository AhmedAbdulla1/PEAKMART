import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/home/domain/entity/content_entity.dart';
import 'package:peakmart/features/home/presentation/state_m/content_cubit/cubit.dart';
import 'package:peakmart/features/home/presentation/state_m/content_cubit/state.dart';
import 'package:peakmart/features/home/presentation/views/partners_section/partner_card.dart';

class PartnersView extends StatelessWidget {
  PartnersView({super.key});

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
            (element) => element.sectionName == SectionName.Parteners);
        return Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p20, horizontal: AppPadding.p30),
          child: Column(
            children: [
              Text(
                _contentData.content,
                style: getBoldStyle(
                    fontSize: FontSize.s16, color: ColorManager.primary),
              ),
              6.vGap,
              Text(
                _contentData.subTitle ?? "",
                style: getRegularStyle(
                    fontSize: FontSize.s12,
                    color: context.isDarkMode
                        ? ColorManager.white
                        : ColorManager.grey1),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: PartnerCard(imageLink: _contentData.image["p1"])),
                  Expanded(
                      child: PartnerCard(imageLink: _contentData.image["p2"])),
                  Expanded(
                      child: PartnerCard(imageLink: _contentData.image["p3"])),
                  Expanded(
                      child: PartnerCard(imageLink: _contentData.image["p4"])),
                ],
              ),
            ],
          ),
        );
      }
      return const WaitingWidget();
    });
  }
}
