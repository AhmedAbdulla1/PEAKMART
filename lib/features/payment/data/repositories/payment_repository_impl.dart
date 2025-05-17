import 'package:dartz/dartz.dart';
import 'package:peakmart/features/payment/domain/entities/fee_entity.dart';
import '../../domain/entities/payment_entity.dart';
import '../../domain/failures/failures.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/remote_payment_datasource.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final RemotePaymentDataSource dataSource;

  PaymentRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, PaymentEntity>> fetchPaymentDetails(String tapId) async {
    try {
      final payment = await dataSource.fetchPaymentDetails(tapId);
      return Right(payment);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  @override
  Future<Either<Failure, FeesEntity>> fetchPaymentFees() async {
    try {
      final payment = await dataSource.fetchPaymentFees();
      return Right(payment);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}