import 'dart:convert';

import 'package:Bid_Mart/core/entities/empty_entity.dart';
import 'package:Bid_Mart/core/models/base_model.dart';

class EmptyResponse extends BaseResponse<EmptyEntity> {
  EmptyResponse(
      {required super.message, required super.status, required super.code});

  factory EmptyResponse.fromJson(dynamic data) {
    Map<String, dynamic> jsonData;

    // التحقق من نوع البيانات
    if (data is Map<String, dynamic>) {
      // البيانات JSON بالفعل
      jsonData = data;
    } else if (data is String) {
      // البيانات String، نحولها لـ JSON
      try {
        jsonData = jsonDecode(data);
      } catch (e) {
        // لو فشل التحويل، نرجع قيم افتراضية مع تسجيل الخطأ
        print('Error decoding JSON: $e');
        return EmptyResponse(
          message: 'Invalid JSON format',
          status: 'error',
          code: 0,
        );
      }
    } else {
      // نوع بيانات غير مدعوم
      print('Unsupported data type: ${data.runtimeType}');
      return EmptyResponse(
        message: 'Invalid data type',
        status: 'error',
        code: 0,
      );
    }
    // إنشاء الكائن من JSON
    return EmptyResponse(
      message: jsonData['message']?.toString() ?? '',
      status: jsonData['status']?.toString() ?? '',
      code: jsonData['status_code'] is int ? jsonData['status_code'] : 0,
    );
  }

  @override
  EmptyEntity toEntity() {
    return EmptyEntity(message: message, status: status, code: code);
  }
}
