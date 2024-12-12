import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/errors/app_errors.dart';
import 'package:peakmart/app/results/result.dart';
import 'package:peakmart/features/auth/data/model/request/login_request.dart';
import 'package:peakmart/features/auth/domain/entity/login_entity.dart';
import 'package:peakmart/features/auth/domain/usecase/login_usecase.dart';

// import 'package:logger/logger.dart';
part 'sign_up_state.dart';

class LoginCubit extends Cubit<SignUpState> {
  LoginUsecase loginUsecase = LoginUsecase();

  LoginCubit() : super(SignUpInitialState());

  Future<void> login(
      {required String email, required String password}) async {
    emit(SignUpLoadingState());
    Result<AppErrors, LoginEntity> result = await loginUsecase
        .login(LoginRequest(email: email, password: password));
    result.pick(onData: (data) {
      emit(SignUpSuccessState());
    }, onError: (error) {
      emit(SignUpFailureState(errors: error, onRetry: () {}));
    });
  }

}
