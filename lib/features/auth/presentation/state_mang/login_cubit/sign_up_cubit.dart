import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/auth/data/model/request/login_request.dart';
import 'package:peakmart/features/auth/domain/entity/login_entity.dart';
import 'package:peakmart/features/auth/domain/repository/auth_repo.dart';

part 'sign_up_state.dart';

class LoginCubit extends Cubit<SignUpState> {
  AuthRepo authRepo = instance<AuthRepo>();

  LoginCubit() : super(SignUpInitialState());

  Future<void> login(
      {required String email, required String password}) async {
    emit(SignUpLoadingState());
    Result<AppErrors, LoginEntity> result = await authRepo
        .login(LoginRequest(email: email, password: password));
    result.pick(onData: (data) {
      emit(SignUpSuccessState());
    }, onError: (error) {
      emit(SignUpFailureState(errors: error, onRetry: () {}));
    });
  }
}
