import 'package:peakmart/features/payment/domain/entities/fee_entity.dart';

enum PaymentProcess {
  UPLOAD,
  ENROLL,
  BID;

  num getFee(FeesEntity fees) {
    switch (this) {
      case PaymentProcess.UPLOAD:
        return (fees.uploadFee + fees.payFee) / 100;
      case PaymentProcess.ENROLL:
        return (fees.enrollFee + fees.payFee) / 100;
      case PaymentProcess.BID:
        return (fees.bidFee + fees.payFee) / 100;
    }
  }
}

enum PaymentType {
  binance,
  tap,
}

enum PaymentStatus {
  pending,
  cancelled,
  success,
  failed,
}