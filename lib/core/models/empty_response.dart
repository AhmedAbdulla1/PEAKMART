import 'package:peakmart/core/entities/base_entity.dart';

import 'base_model.dart';

class EmptyResponse extends BaseResponse {

  EmptyResponse(

  ) : super(message: '', status: '');

  // factory EmptyResponse.fromMap(Map<String, dynamic> json) => EmptyResponse(
  //       s: json["succeed"] ?? false,
  //       message: json["message"] ?? "",
  //     );
  //
  // Map<String, dynamic> toMap() => {
  //       "succeed": succeed,
  //       "message": message,
  //     };

  @override
  BaseEntity toEntity() {
    throw UnimplementedError();
  }
}
