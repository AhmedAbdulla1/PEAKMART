import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
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
    log('Starting confirmPayment...');
    log("Data being sent: ${data.toString()}");

    try {
      // التأكد من أن الـ URL صالح
      const urlString = APIUrls.confirmPayment;
      log('URL: $urlString');
      if (urlString.isEmpty) {
        throw ArgumentError('Confirm Payment URL is empty');
      }

      Uri uri;
      try {
        uri = Uri.parse(urlString);
      } catch (e) {
        log('Error parsing URL: $e');
        throw FormatException('Invalid URL format: $urlString');
      }

      // التأكد من أن الـ Body صالح
      if (data == null || data.isEmpty) {
        log('Error: Request body is null or empty');
        throw ArgumentError('Request body cannot be null or empty');
      }

      log('Sending POST request to $urlString with body: $data');
      final response = await client.post(
        uri,
        body: json.encode(data), // استخدام bodyFields بدل body لـ Form Data
        headers: {
          'Content-Type': 'application/json', // تغيير الـ Content-Type
        },
      ).timeout(Duration(seconds: 30), onTimeout: () {
        log('Request timed out after 30 seconds');
        throw NetworkFailure('Request timed out');
      });

      log('Received response with status code: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final responseData = jsonDecode(response.body);
          log('Parsed response data: $responseData');
          return EmptyResponse(
            message: responseData['message'] ?? 'Payment confirmed',
            status: responseData['status'] ?? 'success',
            code: responseData['code'] ?? 0,
          );
        } catch (e) {
          log('Error parsing response body: $e');
          throw ParsingFailure('Failed to parse response: $e');
        }
      } else if (response.statusCode == 0 || response.statusCode == -1) {
        log('Network error detected');
        throw NetworkFailure('Network error: No connection');
      } else {
        log('Server error: ${response.statusCode} - ${response.reasonPhrase}');
        throw ServerFailure('Server error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e, stackTrace) {
      log('Error in confirmPayment: $e');
      log('Stack trace: $stackTrace');
      if (e is NetworkFailure) {
        throw e;
      } else if (e is ParsingFailure) {
        throw e;
      } else if (e is FormatException) {
        throw ServerFailure('Invalid URL or data format: $e');
      }
      throw ServerFailure('Unexpected error: $e');
    }
  }
}
