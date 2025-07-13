import 'package:dartz/dartz.dart';
import 'package:Bid_Mart/core/entities/empty_entity.dart';
import 'package:Bid_Mart/features/payment/data/model/request.dart';
import 'package:Bid_Mart/features/payment/domain/entities/fee_entity.dart';
import 'package:Bid_Mart/features/payment/domain/failures/failures.dart';
import 'package:Bid_Mart/features/payment/domain/entities/payment_entity.dart';

abstract class PaymentRepository {
  Future<Either<Failure, PaymentEntity>> fetchPaymentDetails(String tapId);
  Future<Either<Failure, FeesEntity>> fetchPaymentFees();
  Future<Either<Failure, EmptyEntity>> confirmPayment(ConfirmPaymentRequest request);
}