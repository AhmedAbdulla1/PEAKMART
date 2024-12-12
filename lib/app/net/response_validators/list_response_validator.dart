
import 'package:peakmart/app/errors/app_errors.dart';
import 'package:peakmart/app/net/response_validators/response_validator.dart';

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
