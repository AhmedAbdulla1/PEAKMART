import 'package:dartz/dartz.dart';
import 'package:peakmart/features/payment/data/datasources/remote_payment_datasource.dart';
import 'package:peakmart/features/payment/data/repositories/payment_repository_impl.dart';
import 'package:peakmart/features/payment/domain/entities/fee_entity.dart';
import 'package:peakmart/features/payment/domain/failures/failures.dart';
import '../entities/payment_entity.dart';
import '../repositories/payment_repository.dart';

class FetchPaymentDetails {
  final PaymentRepository repository = PaymentRepositoryImpl(RemotePaymentDataSourceImpl());

  FetchPaymentDetails();

  Future<Either<Failure, PaymentEntity>> call(String tapId) async {
    return await repository.fetchPaymentDetails(tapId);
  }
  Future<Either<Failure, FeesEntity>> fetchFees() async {
    return await repository.fetchPaymentFees();
  }
}