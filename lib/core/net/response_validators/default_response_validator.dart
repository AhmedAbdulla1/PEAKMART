
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/net/response_validators/response_validator.dart';

class DefaultResponseValidator extends ResponseValidator {
  @override
  void processData(dynamic data) {
    print("data"+ data.toString());
    if (!(data["status"]=="success"   )) {
      error = AppErrors.customError(message: data["message"]?? "");
      errorMessage = data["message"] ?? "";
    }
  }
}
