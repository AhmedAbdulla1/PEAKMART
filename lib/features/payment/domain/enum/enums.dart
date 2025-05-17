import 'package:peakmart/features/payment/domain/entities/fee_entity.dart';

enum PaymentProcess {
  upload,
  enroll,
  bid;

  num getFee(FeesEntity fees) {
    switch (this) {
      case PaymentProcess.upload:
        return fees.uploadFee;
      case PaymentProcess.enroll:
        return fees.enrollFee;
      case PaymentProcess.bid:
        return fees.bidFee;
    }
  }
}

enum PaymentType {
  binance,
  tap,
}
