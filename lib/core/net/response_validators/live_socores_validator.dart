import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/core/net/response_validators/response_validator.dart';

class LiveSocoresValidator extends ResponseValidator{
  @override
  void processData(data) {
    if ((data["success"] == false)) {
      error = AppErrors.customError(message: data["error"]?["message"] ?? "sssssssss");
      errorMessage = data["error"]?["message"] ?? "aaaaaaaaaaaaaaa";
    }
  }

}