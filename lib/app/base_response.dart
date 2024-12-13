import 'package:peakmart/core/entities/base_entity.dart';

abstract class BaseResponse<T extends BaseEntity> {
  String message;
  String status;

  BaseResponse(
      {required this.message, required this.status});

  T toEntity();
}
