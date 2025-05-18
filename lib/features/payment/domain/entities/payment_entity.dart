import 'package:peakmart/features/payment/domain/enum/enums.dart';

class PaymentEntity {
  final String id;
  final String status;
  final double amount;
  final String currency;
  final String customerName;
  final String tapId;

  PaymentEntity({
    required this.id,
    required this.status,
    required this.amount,
    required this.currency,
    required this.customerName,
    required this.tapId,
  })  : assert(id.isNotEmpty, 'Payment ID cannot be empty'),
        assert(amount >= 0, 'Amount cannot be negative'),
        assert(currency.isNotEmpty, 'Currency cannot be empty');
}