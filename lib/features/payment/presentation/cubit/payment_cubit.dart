import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Bid_Mart/features/payment/data/model/request.dart';
import 'package:Bid_Mart/features/payment/domain/entities/fee_entity.dart';
import 'package:Bid_Mart/features/payment/domain/entities/payment_entity.dart';
import 'package:Bid_Mart/features/payment/domain/enum/enums.dart';
import 'package:Bid_Mart/features/payment/domain/failures/failures.dart';
import 'package:Bid_Mart/features/payment/domain/usecases/payment_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final FetchPaymentDetails useCase;
  final PaymentProcess paymentProcess;

  PaymentCubit({required this.useCase, required this.paymentProcess})
      : super(PaymentInitial());
  late PaymentEntity payment;
  late FeesEntity fees;

  Future<void> loadPaymentDetails(String tapId) async {
    emit(PaymentLoading());
    final result = await useCase.fetchPaymentDetails(tapId);
    result.fold(
      (failure) {
        String errorMessage;
        if (failure is NetworkFailure) {
          errorMessage = 'Please check your internet connection.';
        } else if (failure is ServerFailure) {
          errorMessage = 'Server error, try again later.';
        } else if (failure is ParsingFailure) {
          errorMessage = 'Error parsing payment details.';
        } else {
          errorMessage = 'An error occurred: ${failure.message}';
        }
        emit(PaymentError(errorMessage));
      },
      (payment) {
        this.payment = payment;
        emit(PaymentLoaded(payment));
      },
    );
  }

  Future<void> loadPaymentFees() async {
    emit(PaymentLoading());
    // final cachedFees = await _getCachedFees();
    // if (cachedFees != null) {
    //   fees = cachedFees;
    //   emit(FeesLoaded(cachedFees));
    //   return;
    // }
    final result = await useCase.fetchPaymentFees();
    result.fold(
      (failure) {
        String errorMessage;
        if (failure is NetworkFailure) {
          errorMessage = 'Please check your internet connection.';
        } else if (failure is ServerFailure) {
          errorMessage = 'Server error, try again later.';
        } else if (failure is ParsingFailure) {
          errorMessage = 'Error parsing fees.';
        } else {
          errorMessage = 'An error occurred: ${failure.message}';
        }
        emit(PaymentError(errorMessage));
      },
      (fees) {
        this.fees = fees;
        _cacheFees(fees);
        emit(FeesLoaded(fees));
      },
    );
  }

  Future<void> confirmPayment() async {
    emit(PaymentLoading());
    log("payment in cubit ${payment.tapId}");
    final result = await useCase.confirmPayment(ConfirmPaymentRequest(
      amount: payment.amount,
      reason: paymentProcess.name.toUpperCase(),
      tapId: payment.tapId,
    ));
    log("reuslt in cubit $result");
    result.fold(
      (failure) {
        String errorMessage;
        log("failure in cubit $failure");
        if (failure is NetworkFailure) {
          errorMessage = 'Please check your internet connection.';
          log("errorMessage1 in cubit $errorMessage");
        } else if (failure is ServerFailure) {
          errorMessage = 'Server error, try again later.';
          log("errorMessage2 in cubit $errorMessage");
        } else {
          errorMessage = 'An error occurred: ${failure.message}';
          log("errorMessage3 in cubit $errorMessage");
        }
        log("errorMessage4 in cubit $errorMessage");

        emit(PaymentError(errorMessage));
      },
      (_) {
        log('Payment Confirmed............');
        emit(PaymentSuccess());
      },
    );
  }

  Future<FeesEntity?> _getCachedFees() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString('cached_fees');
    if (cached == null) return null;
    final data = jsonDecode(cached);
    return FeesEntity(
      upload: data['upload'],
      uploadFee: data['uploadFee'],
      enrollFee: data['enrollFee'],
      payFee: data['payFee'],
      bidFee: data['BidFee'],
    );
  }

  Future<void> _cacheFees(FeesEntity fees) async {
    final prefs = await SharedPreferences.getInstance();
    final data = {
      'upload': fees.upload,
      'uploadFee': fees.uploadFee,
      'enrollFee': fees.enrollFee,
      'payFee': fees.payFee,
      'BidFee': fees.bidFee,
    };
    await prefs.setString('cached_fees', jsonEncode(data));
  }
}
