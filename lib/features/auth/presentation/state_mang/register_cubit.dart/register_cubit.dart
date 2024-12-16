import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/error_ui/dialogs/show_dialog.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
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
    ShowDialog().showElasticDialog(
      context: context,
      builder: (context) => WaitingWidget(),
      barrierDismissible: false,
    );
    debugPrint('in cubit email is ${registerRequest.email}');
    Result<AppErrors, RegisterEntity> result = await authRepo.register(
      RegisterRequest(
          email: registerRequest.email,
          password: registerRequest.password,
          userName: registerRequest.userName,
          phoneNumber: registerRequest.phoneNumber),
    );


    result.pick(onData: (data) {
      debugPrint(
        'data in cubit is $data',
      );
      Navigator.pop(context);
      emit(
        RegisterSuccessState(),
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
