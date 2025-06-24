import 'dart:convert';

import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/net/response_validators/response_validator.dart';

class DefaultResponseValidator extends ResponseValidator {
  @override
  void processData(dynamic data) {
    print('In default validator');
    print('data type ${data.runtimeType}');

    Map<String, dynamic> jsonData;

    if (data is Map<String, dynamic>) {
      jsonData = data;
    } else {
      try {
        jsonData = jsonDecode(data.toString());
      } catch (e) {
        print('Error decoding JSON: $e');
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
