import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:peakmart/features/payment/domain/entities/fee_entity.dart';
import '../../domain/entities/payment_entity.dart';
import '../../domain/usecases/fetch_payment_details.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final FetchPaymentDetails fetchPaymentDetails;

  PaymentCubit(this.fetchPaymentDetails) : super(PaymentInitial());

  Future<void> loadPaymentDetails(String tapId) async {
    emit(PaymentLoading());
    final result = await fetchPaymentDetails(tapId);
    result.fold(
      (failure) => emit(PaymentError(failure.message)),
      (payment) => emit(PaymentLoaded(payment)),
    );
  }

  Future<void> loadPaymentFees() async {
    emit(PaymentLoading());
    final result = await fetchPaymentDetails.fetchFees();
    result.fold(
      (failure) => emit(PaymentError(failure.message)),
      (fees) => emit(FeesLoaded(fees)),
    );
  }
}
