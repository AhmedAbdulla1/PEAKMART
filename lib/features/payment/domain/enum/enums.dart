import 'package:peakmart/features/payment/domain/entities/fee_entity.dart';

enum PaymentProcess {
  upload,
  enroll,
  bid;

  num getFee(FeesEntity fees) {
    switch (this) {
      case PaymentProcess.upload:
        return (fees.uploadFee+fees.payFee)/100;
      case PaymentProcess.enroll:
        return (fees.enrollFee+fees.payFee)/100;
      case PaymentProcess.bid:
        return (fees.bidFee+fees.payFee)/100;
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