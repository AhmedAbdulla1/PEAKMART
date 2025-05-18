import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:peakmart/core/net/api_url.dart';
import 'package:peakmart/core/responses/emty_response.dart';
import 'package:peakmart/features/payment/domain/entities/fee_entity.dart';
import 'package:peakmart/features/payment/domain/entities/payment_entity.dart';
import 'package:peakmart/features/payment/domain/failures/failures.dart';

abstract class RemotePaymentDataSource {
  Future<PaymentEntity> fetchPaymentDetails(String tapId);

  Future<FeesEntity> fetchPaymentFees();

  Future<EmptyResponse> confirmPayment(Map<String, dynamic> data);
}

class RemotePaymentDataSourceImpl implements RemotePaymentDataSource {
  final http.Client client;

  RemotePaymentDataSourceImpl(this.client);

  @override
  Future<PaymentEntity> fetchPaymentDetails(String tapId) async {
    final url = '${APIUrls.paymentDetails}?tap_id=$tapId';
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        log(response.body);
        final data = jsonDecode(response.body);
        if (data['id'] == null || data['id'].toString().isEmpty) {
          throw ParsingFailure('Payment ID is missing or empty');
        }
        log('after json decode');
        print(data);
        return PaymentEntity(
          id: data['id'],
          status: data['status'] ?? 'CAPTURED',
          amount: data['amount'] is int
              ? data['amount'].toDouble()
              : data['amount'] ?? 0.0,
          currency: data['currency'] ?? 'USD',
          customerName: data['customer']?['first_name'] ?? 'Unknown',
          tapId: tapId,
        );
      } catch (e) {
        log(e.toString());
        throw ParsingFailure('Failed to parse payment details: $e');
      }
    } else if (response.statusCode == 0 || response.statusCode == -1) {
      throw NetworkFailure('Network error: No connection');
    } else {
      throw ServerFailure(
          'Server error: ${response.statusCode} - ${response.reasonPhrase}');
    }
  }

  @override
  Future<FeesEntity> fetchPaymentFees() async {
    final response = await client.get(Uri.parse(APIUrls.paymentFees));

    if (response.statusCode == 200) {
      print(response.body);
      try {
        final data = jsonDecode(response.body);
        return FeesEntity(
          upload: data['upload'] ?? 100,
          uploadFee: data['uploadFee'] ?? 10,
          enrollFee: data['enrollFee'] ?? 10.0,
          payFee: data['payFee'] ?? 10,
          bidFee: data['BidFee'] ?? 10,
        );
      } catch (e) {
        throw ParsingFailure('Failed to parse fees: $e');
      }
    } else if (response.statusCode == 0 || response.statusCode == -1) {
      throw NetworkFailure('Network error: No connection');
    } else {
      throw ServerFailure(
          'Server error: ${response.statusCode} - ${response.reasonPhrase}');
    }
  }

  @override
  Future<EmptyResponse> confirmPayment(Map<String, dynamic> data) async {
    log('5555555555555555555555555555');
    log("data: ${data.toString()}");
    try {
      final response =
          await client.post(Uri.parse(APIUrls.confirmPayment), body: data);
      log('4444444444444444444444444');
      log(response.statusCode.toString());
      log(response.body);
      log('100000000000000');
      // if (response.statusCode == 200) {
      //   final data = jsonDecode(response.body);
      //   log('587878777777777777');

      //   return EmptyResponse(
      //       message: data['message'], status: data['status'], code: 0);
      // } else if (response.statusCode == 0 || response.statusCode == -1) {
      //   log('9999999999999999999999');

      //   throw NetworkFailure('Network error: No connection');
      // } else {
      //   log('0000000000000000000000');

      //   throw ServerFailure(
      //       'Server error: ${response.statusCode} - ${response.reasonPhrase}');
      // }
      return EmptyResponse(
        message: 'Payment confirmed',
        status: 'success',
        code: 0,
      );
    } on Exception catch (e) {
      log("ppppppppppppppppp");
      log(e.toString());
      throw ServerFailure('Server error: ${e.toString()}');
    }
  }
}
