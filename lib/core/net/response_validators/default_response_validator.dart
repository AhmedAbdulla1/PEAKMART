import 'dart:convert';

import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/core/net/response_validators/response_validator.dart';
import 'package:flutter/material.dart';

class DefaultResponseValidator extends ResponseValidator {
  @override
  void processData(dynamic data) {
    debugPrint('In default validator');
    debugPrint('data type ${data.runtimeType}');

    Map<String, dynamic> jsonData;

    if (data is Map<String, dynamic>) {
      jsonData = data;
    } else {
      try {
        jsonData = jsonDecode(data.toString());
      } catch (e) {
        debugPrint('Error decoding JSON: $e');
        error = const AppErrors.customError(message: 'Invalid data format');
        errorMessage = 'Invalid data format';
        return;
      }
    }

    if (jsonData['status'] != 'success') {
      error = AppErrors.customError(
          message: jsonData['message'] ?? 'Unknown error');
      errorMessage = jsonData['message'] ?? 'Unknown error';
    }
  }
}
