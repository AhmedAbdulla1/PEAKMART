// screens/summary_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/profile/domain/enitiy/user_info_entity.dart';
import 'package:peakmart/features/profile/presentation/profile/profile_body.dart';
import 'package:peakmart/features/profile/presentation/state_m/profile/cubit.dart';

class SummaryProfileScreen extends StatelessWidget {
  const SummaryProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..fetchProfile(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ErrorViewer.showError(
                context: context, error: state.error, callback: () {});
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: WaitingWidget());
          } else if (state is ProfileLoaded) {
            return ProfileScreen(userinfo: state.userInfo);
          } else if (state is ProfileError) {
            return const ProfileScreen(
                userinfo: UserInfoEntity(
                    userName: "Ahmed",
                    phone: "01099409512",
                    photo: "https://picsum.photos/800/600",
                    sellerInfo: "",
                    email: "ahmedelabassy14@gmail.com"));
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
