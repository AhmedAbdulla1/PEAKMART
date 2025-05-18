import 'package:dartz/dartz.dart';
import 'package:peakmart/core/entities/empty_entity.dart';
import 'package:peakmart/features/payment/data/model/request.dart';
import 'package:peakmart/features/payment/domain/entities/fee_entity.dart';
import 'package:peakmart/features/payment/domain/entities/payment_entity.dart';
import 'package:peakmart/features/payment/domain/failures/failures.dart';
import 'package:peakmart/features/payment/domain/repositories/payment_repository.dart';
import 'package:peakmart/features/payment/data/datasources/remote_payment_datasource.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final RemotePaymentDataSource dataSource;

  PaymentRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, PaymentEntity>> fetchPaymentDetails(String tapId) async {
    try {
      final payment = await dataSource.fetchPaymentDetails(tapId);
      return Right(payment);
    } catch (e) {
      if (e is NetworkFailure) {
        return Left(NetworkFailure(e.message));
      } else if (e is ParsingFailure) {
        return Left(ParsingFailure(e.message));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FeesEntity>> fetchPaymentFees() async {
    try {
      final fees = await dataSource.fetchPaymentFees();
      return Right(fees);
    } catch (e) {
      if (e is NetworkFailure) {
        return Left(NetworkFailure(e.message));
      } else if (e is ParsingFailure) {
        return Left(ParsingFailure(e.message));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, EmptyEntity>> confirmPayment(ConfirmPaymentRequest request) async {
    try {
      final payment = await dataSource.confirmPayment(request.toJson());
      return Right(payment.toEntity());
    } catch (e) {
      if (e is NetworkFailure) {
        return Left(NetworkFailure(e.message));
      } else if (e is ParsingFailure) {
        return Left(ParsingFailure(e.message));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}