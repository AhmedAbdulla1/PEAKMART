import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/auth/presentation/state_mang/user_info_cubit/user_info_cubit.dart';
import 'package:peakmart/features/home/domain/entity/content_entity.dart';
import 'package:peakmart/features/home/presentation/state_m/content_cubit/cubit.dart';
import 'package:peakmart/features/home/presentation/state_m/content_cubit/state.dart';
import 'package:peakmart/features/home/presentation/views/landing_section/content_loaded.dart';

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
      // ignore: use_build_context_synchronously
      context.read<ContentCubit>().getContent();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
        return BlocProvider(
          create: (context) => UserInfoCubit()..userInfo(),
          child: ContentLoadedWidget(
              contentData: _contentData, buttonText: buttonText),
        );
      }
      return const Center(child: WaitingWidget());
    });
  }
}
