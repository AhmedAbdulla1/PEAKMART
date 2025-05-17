import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:peakmart/features/payment/domain/entities/fee_entity.dart';
import 'package:peakmart/features/payment/domain/entities/payment_entity.dart';
import 'package:peakmart/features/payment/domain/failures/failures.dart';

abstract class RemotePaymentDataSource {
  Future<PaymentEntity> fetchPaymentDetails(String tapId);
  Future<FeesEntity> fetchPaymentFees();

}

class RemotePaymentDataSourceImpl implements RemotePaymentDataSource {
  final http.Client client = http.Client();

  RemotePaymentDataSourceImpl();

  @override
  Future<PaymentEntity> fetchPaymentDetails(String tapId) async {
    final url = 'https://hk.herova.net/payment/ret_pay.php?tap_id=$tapId';
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return PaymentEntity(
        id: data['id'] ?? '',
        status: data['status'] ?? 'CAPTURED',
        amount: data['amount'] is int ? data['amount'].toDouble() : data['amount'] ?? 0.0,
        currency: data['currency'] ?? 'USD',
        customerName: data['customer']?['first_name'] ?? 'Unknown',
        tapId: tapId,
      );
    } else {
      throw ServerFailure('Failed to fetch payment details: ${response.statusCode}');
    }
  }

  @override
  Future<FeesEntity> fetchPaymentFees() async {
    const url = 'https://hk.herova.net/payment/paydetails.php';
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return FeesEntity(
        upload: data['upload'] ?? 100,
        uploadFee: data['uploadFee'] ?? 10,
        enrollFee: data['enrollFee'] ?? 10.0,
        payFee: data['payFee'] ?? 10,
        bidFee: data['BidFee']?? 10,
      );
    } else {
      throw ServerFailure('Failed to fetch payment details: ${response.statusCode}');
    }
  }

}
