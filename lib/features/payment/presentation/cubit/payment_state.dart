part of 'payment_cubit.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final PaymentEntity payment;

  const PaymentLoaded(this.payment);

  @override
  List<Object> get props => [payment];
}

class FeesLoaded extends PaymentState {
  final FeesEntity fees;

  const FeesLoaded(this.fees);

  @override
  List<Object> get props => [fees];
}

class PaymentError extends PaymentState {
  final String message;

  const PaymentError(this.message);

  @override
  List<Object> get props => [message];
}