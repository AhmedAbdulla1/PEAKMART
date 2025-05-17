import 'package:dartz/dartz.dart';
import 'package:peakmart/features/payment/domain/entities/fee_entity.dart';
import 'package:peakmart/features/payment/domain/failures/failures.dart';
import '../entities/payment_entity.dart';

abstract class PaymentRepository {
  Future<Either<Failure, PaymentEntity>> fetchPaymentDetails(String tapId);
  Future<Either<Failure, FeesEntity>> fetchPaymentFees();
}