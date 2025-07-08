import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/error_ui/dialogs/show_dialog.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/auth/data/model/request/login_request.dart';
import 'package:peakmart/features/auth/domain/entity/login_entity.dart';
import 'package:peakmart/features/auth/domain/repository/auth_repo.dart';
import 'package:peakmart/features/notifications/data/firebase_cloud_messaging_service.dart';

part 'state.dart';

class LoginCubit extends Cubit<LoginState> {
  AuthRepo authRepo = instance<AuthRepo>();
  AppPreferences appPreferences = instance<AppPreferences>();
  LoginCubit() : super(LoginInitialState());
  late BuildContext context;

  Future<void> login({required String email, required String password}) async {
    final String? token = FirebaseCloudMessagingService.token;
    emit(LoginLoadingState());
    ShowDialog().showElasticDialog(
        context: context,
        builder: (context) => const WaitingWidget(),
        barrierDismissible: true);

    Result<AppErrors, LoginEntity> result = await authRepo.login(
        LoginRequest(email: email, password: password, fCMToken: token!));
    result.pick(onData: (data) {
      Navigator.pop(context);
      emit(LoginSuccessState());
      appPreferences.setPressKeyLoginScreen();
      appPreferences.setUserId(data.userId);
      appPreferences.setUserPassword(password);
    }, onError: (error) {
      Navigator.pop(context);
      emit(LoginFailureState(errors: error, onRetry: () {}));
    });
  }
}
