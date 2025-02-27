import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/auth/domain/entity/user_info_entity.dart';
import 'package:peakmart/features/auth/domain/repository/auth_repo.dart';

part 'user_info_states.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  final AuthRepo authRepo = instance<AuthRepo>();

  UserInfoCubit() : super(UserInfoInitialState());
  late BuildContext context;
 static late UserInfoEntity entity;
  Future<void> userInfo() async {
    emit(
      UserInfoLoadingState(),
    );

    Result<AppErrors, UserInfoEntity> result = await authRepo.getUserInfo();
    result.pick(onData: (data) {
      debugPrint(
        'data in UserInfo cubit is $data',
      );
      Navigator.pop(context);
      entity = data;
      emit(
        UserInfoSuccessState(userInfoEntity: data),
      );
    }, onError: (error) {
      log(
        error.toString(),
      );
      Navigator.pop(context);
      emit(
        UserInfoFailureState(
          errors: error,
          onRetry: () {},
        ),
      );
    });
  }
}
