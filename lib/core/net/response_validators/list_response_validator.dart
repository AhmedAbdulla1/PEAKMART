
import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/core/net/response_validators/response_validator.dart';

class ListResponseValidator extends ResponseValidator {
  @override
  void processData(dynamic data) {
    if (data is! List) {
      error =
          const AppErrors.customError(message: '');
      errorMessage = '';
    }
  }
}
