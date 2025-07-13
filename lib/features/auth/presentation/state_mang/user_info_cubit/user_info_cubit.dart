import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Bid_Mart/app/di.dart';
import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/core/results/result.dart';
import 'package:Bid_Mart/features/profile/domain/enitiy/user_info_entity.dart';
import 'package:Bid_Mart/features/profile/domain/profile_repo.dart';

part 'user_info_states.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  final ProfileRepo authRepo = instance<ProfileRepo>();

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
