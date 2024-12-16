import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/auth/data/model/request/register_request.dart';
import 'package:peakmart/features/auth/domain/entity/register_entity.dart';
import 'package:peakmart/features/auth/domain/repository/auth_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  AuthRepo authRepo = instance<AuthRepo>();

  RegisterCubit() : super(RegisterInitialState());
  late BuildContext context;
  Future<void> register({required RegisterRequest registerRequest}) async {
    emit(
      RegisterLoadingState(),
    );


    Result<AppErrors, RegisterEntity> result = await authRepo.register(
      RegisterRequest(
          email: registerRequest.email,
          password: registerRequest.password,
          userName: registerRequest.userName,
          phoneNumber: registerRequest.phoneNumber),
    );
    debugPrint('in cubit email is ${registerRequest.email}');

    result.pick(onData: (data) {
      debugPrint(
        'data in cubit is $data',
      );
      Navigator.pop(context);
      emit(
        RegisterSuccessState(
            registerEntity: RegisterEntity(
                phoneNumber: data.phoneNumber,
                email: data.email,
                userName: data.userName,
                userId: data.userId)),
      );
    }, onError: (error) {
      log(
        error.toString(),
      );
      Navigator.pop(context);
      emit(
        RegisterFailureState(
          errors: error,
          onRetry: () {},
        ),
      );
    });
  }
}
