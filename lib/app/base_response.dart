import 'package:peakmart/app/entities/base_entity.dart';

abstract class BaseResponse<T extends BaseEntity> {
  String message;
  bool status;
  String error;

  BaseResponse(
      {required this.message, required this.status, required this.error});

  T toEntity();
}
