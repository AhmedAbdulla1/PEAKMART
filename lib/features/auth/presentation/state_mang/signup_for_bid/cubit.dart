import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/entities/empty_entity.dart';
import 'package:peakmart/core/error_ui/dialogs/show_dialog.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/auth/data/model/request/login_request.dart';
import 'package:peakmart/features/auth/data/model/request/seller_info_request.dart';
import 'package:peakmart/features/auth/data/model/request/signup_for_bid_request.dart';
import 'package:peakmart/features/auth/domain/entity/login_entity.dart';
import 'package:peakmart/features/auth/domain/repository/auth_repo.dart';

part 'state.dart';

class SignUpForBidCubit extends Cubit<SignUpState> {
  AuthRepo authRepo = instance<AuthRepo>();

  SignUpForBidCubit() : super(SignUpInitial());
  late BuildContext context;

  void moveToDetails() {
    emit(SignUpDetailsLoading());
  }

  void back() {
    emit(SignUpDetailsSuccess());
  }

  Future<void> register(
      {required RegisterAsSellerRequest registerRequest}) async {
    emit(SignUpLoading());
    Result<AppErrors, EmptyEntity> result =
        await authRepo.registerAsSeller(registerRequest: registerRequest);
    result.pick(onData: (data) {
      Navigator.pop(context);
      emit(SignUpSuccess());
    }, onError: (error) {
      Navigator.pop(context);
      emit(SignUpFailure(error: error,));
    });
  }
  Future<void> sellerInfo(
      {required SellerInfoRequest sellerInfo}) async {
    emit(SignUpDetailsLoading());
    Result<AppErrors, EmptyEntity> result =
    await authRepo.sellerInfo(sellerInfoRequest: sellerInfo);
    result.pick(onData: (data) {
      Navigator.pop(context);
      emit(SignUpDetailsSuccess());
    }, onError: (error) {
      Navigator.pop(context);
      emit(SignUpDetailsFailure(error: error, onRetry: () {}));
    });
  }
}
