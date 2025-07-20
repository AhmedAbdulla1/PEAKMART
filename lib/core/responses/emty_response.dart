import 'dart:convert';
import 'dart:developer';

import 'package:Bid_Mart/core/entities/empty_entity.dart';
import 'package:Bid_Mart/core/models/base_model.dart';
import 'package:flutter/material.dart';

class EmptyResponse extends BaseResponse<EmptyEntity> {
  EmptyResponse(
      {required super.message, required super.status, required super.code});

  factory EmptyResponse.fromJson(dynamic data) {
    Map<String, dynamic> jsonData;

    if (data is Map<String, dynamic>) {
      jsonData = data;
    } else if (data is String) {
      try {
        log("data is String: $data");
        jsonData = jsonDecode(data);
      } catch (e) {
        debugPrint('Error decoding JSON: $e');
        return EmptyResponse(
          message: 'Invalid JSON format',
          status: 'error',
          code: 0,
        );
      }
    } else {
      debugPrint('Unsupported data type: ${data.runtimeType}');
      return EmptyResponse(
        message: 'Invalid data type',
        status: 'error',
        code: 0,
      );
    }

    String extractMessage(dynamic msg) {
      if (msg is String) return msg;
      if (msg is Map<String, dynamic>) return msg['en']?.toString() ?? '';
      return '';
    }
    print(jsonData);
    return EmptyResponse(
      message: extractMessage(jsonData['message']),
      status: jsonData['status']?.toString() ?? '',
      code: jsonData['status_code'] is int ? jsonData['status_code'] : 0,
    );
  }

  @override
  EmptyEntity toEntity() {
    return EmptyEntity(message: message, status: status, code: code);
  }
}
