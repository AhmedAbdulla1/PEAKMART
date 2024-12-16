import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/error_ui/dialogs/show_dialog.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/error_ui/error_viewer/toast/errv_toast_options.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/auth/data/model/request/login_request.dart';
import 'package:peakmart/features/auth/domain/entity/login_entity.dart';
import 'package:peakmart/features/auth/domain/repository/auth_repo.dart';

part 'sign_up_state.dart';

class LoginCubit extends Cubit<LoginState> {
  AuthRepo authRepo = instance<AuthRepo>();

  LoginCubit() : super(SignUpInitialState());
  late BuildContext context;

  Future<void> login({required String email, required String password}) async {
    emit(SignUpLoadingState());
    ShowDialog().showElasticDialog(
      context: context,
      builder: (context) => WaitingWidget(),
      barrierDismissible: false,
    );
    Result<AppErrors, LoginEntity> result =
        await authRepo.login(LoginRequest(email: email, password: password));
    result.pick(onData: (data) {
      Navigator.pop(context);
      emit(SignUpSuccessState());
    }, onError: (error) {
      Navigator.pop(context);
      emit(SignUpFailureState(errors: error, onRetry: () {}));
    });
  }
}
