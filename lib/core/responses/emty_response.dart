import 'package:peakmart/core/entities/empty_entity.dart';
import 'package:peakmart/core/models/base_model.dart';

class EmptyResponse extends BaseResponse<EmptyEntity> {
  EmptyResponse(
      {required super.message, required super.status, required super.code});

  factory EmptyResponse.fromJson(Map<String, dynamic> json) {
    return EmptyResponse(
      message: json['message'],
      status: json['status'],
      code: json['code'],
    );
  }

  @override
  EmptyEntity toEntity() {
    return EmptyEntity(message: message, status: status, code: code);
  }
}
