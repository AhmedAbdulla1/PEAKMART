import '../entities/base_entity.dart';

// abstract class BaseModel<T extends BaseEntity>{
//   T toEntity();
// }
abstract class BaseResponse<T extends BaseEntity> {
  String message;
  String status;
  int code;

  BaseResponse(
      {required this.message, required this.status, required this.code});

  T toEntity();
}
