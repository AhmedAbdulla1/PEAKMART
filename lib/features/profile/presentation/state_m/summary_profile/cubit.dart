// cubit/profile_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

part 'state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void fetchProfile() async {
    emit(ProfileLoading());
    try {
      // Simulate fetching profile data from an API
      await Future.delayed(Duration(seconds: 2));


      final profileData = {
        'name': 'Ahmed',
        'email': 'omarahmed14@gmail.com',
        'points': 2354.23,
        'personalInfoCompleted': true,
        'paymentCompleted': false,
      };
      emit(ProfileLoaded(
        summaryProfileModel: SummaryProfileModel(
          name: profileData['name'] as String,
          email: profileData['email'] as String,
          points: profileData['points'] as double,
          personalInfoCompleted: profileData['personalInfoCompleted'] as bool,
          paymentCompleted: profileData['paymentCompleted'] as bool,
        ),
      ));
    } catch (e) {
      emit(ProfileError('Failed to load profile data'));
    }
  }
  void logout(){}
}
