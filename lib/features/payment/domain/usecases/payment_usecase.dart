import 'package:dartz/dartz.dart';
import 'package:peakmart/core/entities/empty_entity.dart';
import 'package:peakmart/features/payment/data/model/request.dart';
import 'package:peakmart/features/payment/domain/entities/fee_entity.dart';
import 'package:peakmart/features/payment/domain/failures/failures.dart';
import 'package:peakmart/features/payment/domain/entities/payment_entity.dart';
import 'package:peakmart/features/payment/domain/repositories/payment_repository.dart';

class FetchPaymentDetails {
  final PaymentRepository repository;

  FetchPaymentDetails({required this.repository});

  Future<Either<Failure, PaymentEntity>> fetchPaymentDetails(String tapId) async {
    return await repository.fetchPaymentDetails(tapId);
  }

  Future<Either<Failure, FeesEntity>> fetchPaymentFees() async {
    return await repository.fetchPaymentFees();
  }

  Future<Either<Failure, EmptyEntity>> confirmPayment(ConfirmPaymentRequest request) async {
    
    return await repository.confirmPayment(request);
  }
}