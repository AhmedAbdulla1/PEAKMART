import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Bid_Mart/app/di.dart';
import 'package:Bid_Mart/core/entities/empty_entity.dart';
import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/core/results/result.dart';
import 'package:Bid_Mart/features/auth/data/model/request/seller_info_request.dart';
import 'package:Bid_Mart/features/auth/data/model/request/signup_for_bid_request.dart';
import 'package:Bid_Mart/features/auth/domain/repository/auth_repo.dart';

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
      emit(SignUpFailure(
        error: error,
      ));
    });
  }

  Future<void> sellerInfo({required SellerInfoRequest sellerInfo}) async {
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
