import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:peakmart/features/profile/presentation/state_m/profile/cubit.dart';
import 'package:peakmart/features/profile/presentation/views/personal_inof/personal_information_view_body.dart';

class PersonalInformationView extends StatefulWidget {
  const PersonalInformationView({super.key});
  static const String routeName = "/personal-info";

  @override
  State<PersonalInformationView> createState() =>
      _PersonalInformationViewState();
}

class _PersonalInformationViewState extends State<PersonalInformationView> {
  bool isRefresh = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileCubit()..fetchProfileIfNeeded(),
        child: Scaffold(
          appBar: const CustomAppBar(
            title: "Personal Information",
            // onBackPressed: () {
            //   // الآن context هنا هو اللي جواه الـ ProfileCubit
            //   final cubit = context.read<ProfileCubit>();
            //   Navigator.pop(context, cubit.hasChanges);
            // },
          ),
          body: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is ProfileError) {
                ErrorViewer.showError(
                  context: context,
                  error: state.error,
                  callback: () =>
                      context.read<ProfileCubit>().fetchProfileIfNeeded(),
                );
              }
            },
            builder: (context, state) {
              final hasData = state is ProfileLoaded;
              final isSaving = state is ProfileLoading && hasData;
              final isInitialLoading = state is ProfileLoading && !hasData;

              if (isInitialLoading) {
                return const Center(child: WaitingWidget());
              }

              return Stack(
                children: [
                  if (hasData) const PersonalInformationViewBody(),
                  if (isSaving)
                    Positioned.fill(
                      child: AbsorbPointer(
                        absorbing: true,
                        child: Container(
                          color: Colors.black.withOpacity(0.3),
                          child: const Center(child: WaitingWidget()),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ));
  }
}
