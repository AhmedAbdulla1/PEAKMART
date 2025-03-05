// screens/summary_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/features/profile/presentation/state_m/summary_profile/cubit.dart';
import 'package:peakmart/features/profile/presentation/summary_profile/profile_body.dart';

class SummaryProfileScreen extends StatelessWidget {
  const SummaryProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..fetchProfile(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return ProfileScreen(model: state.summaryProfileModel);
          } else if (state is ProfileError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
