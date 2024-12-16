import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/entities/empty_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/auth/data/model/request/rest_password_request.dart';
import 'package:peakmart/features/auth/domain/repository/auth_repo.dart';

part 'states.dart';

class RestPassCubit extends Cubit<ResetPassState> {
  AuthRepo authRepo = instance<AuthRepo>();
  String email = '';
  RestPassCubit() : super(ResetPassInitialState());

  Future<void> resetPassword({required String email}) async {
    this.email = email;
    emit(ResetPassLoadingState());
    Result<AppErrors, EmptyEntity> result =
        await authRepo.restPassword(RestPasswordRequest(
      email: email,
    ));
    result.pick(onData: (data) {
      emit(ResetPassSuccessState());
    }, onError: (error) {
      emit(ResetPassFailureState(errors: error, onRetry: () {}));
    });
  }
  Future<void> resend() async {
    await authRepo.restPassword(RestPasswordRequest(
      email: email,
    ));
  }
}
