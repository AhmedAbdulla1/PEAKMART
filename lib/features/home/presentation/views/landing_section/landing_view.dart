import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/auth/presentation/state_mang/user_info_cubit/user_info_cubit.dart';
import 'package:peakmart/features/home/domain/entity/content_entity.dart';
import 'package:peakmart/features/home/presentation/state_m/content_cubit/cubit.dart';
import 'package:peakmart/features/home/presentation/state_m/content_cubit/state.dart';
import 'package:peakmart/features/home/presentation/views/landing_section/content_loaded.dart';

// Fake ContentData for skeleton loading
ContentData fakeContentData = ContentData(
  sectionName: SectionName.Cover,
  subTitle: 'Placeholder Title',
  content: 'Placeholder subtitle text for skeleton loading',
  image: {
    'background': '',
    'image': '',
  },
  id: 0,
  subContent: 'Placeholder subtitle text for skeleton loading',
  subHead: 'Placeholder subtitle text for skeleton loading',
);

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final String buttonText = "Join Now";

  ContentData? _contentData;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ContentCubit>().getContent();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ContentCubit, ContentState>(
      builder: (context, state) {
        if (state is ContentError) {
          ErrorViewer.showError(
            context: context,
            error: state.errors,
            callback: () {},
          );
        }

        if (state is ContentLoading || state is ContentInitial) {
          return Skeletonizer(
            enabled: true,
            enableSwitchAnimation: true,
            child: ContentLoadedWidget(
              contentData: fakeContentData,
              buttonText: buttonText,
            ),
          );
        }

        if (state is ContentLoaded) {
          _contentData = state.contentEntity.data.firstWhere(
            (element) => element.sectionName == SectionName.Cover,
            orElse: () => fakeContentData,
          );
          return BlocProvider(
            create: (context) => UserInfoCubit()..userInfo(),
            child: ContentLoadedWidget(
              contentData: _contentData!,
              buttonText: buttonText,
            ),
          );
        }

        return Skeletonizer(
          enabled: true,
          enableSwitchAnimation: true,
          child: ContentLoadedWidget(
            contentData: fakeContentData,
            buttonText: buttonText,
          ),
        );
      },
    );
  }
}
