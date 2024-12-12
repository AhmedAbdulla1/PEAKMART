
import 'package:peakmart/app/errors/app_errors.dart';
import 'package:peakmart/app/net/response_validators/response_validator.dart';

class DefaultResponseValidator extends ResponseValidator {
  @override
  void processData(dynamic data) {
    if (!(data["success"] ?? false)) {
      error = AppErrors.customError(message: data["error"]?["message"] ?? "");
      errorMessage = data["error"]?["message"] ?? "";
    }
  }
}
