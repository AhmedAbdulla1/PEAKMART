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
  });
}