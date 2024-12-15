
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/net/response_validators/response_validator.dart';

class ListResponseValidator extends ResponseValidator {
  @override
  void processData(dynamic data) {
    if (!(data is List)) {
      error =
          AppErrors.customError(message: '');
      errorMessage = '';
    }
  }
}
