import '../entities/base_entity.dart';

// abstract class BaseModel<T extends BaseEntity>{
//   T toEntity();
// }
abstract class BaseResponse<T extends BaseEntity> {
  String message;
  String status;

  BaseResponse(
      {required this.message, required this.status});

  T toEntity();
}
