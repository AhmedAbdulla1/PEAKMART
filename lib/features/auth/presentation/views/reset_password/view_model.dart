import 'dart:async';
import 'package:peakmart/core/resources/string_manager.dart';

class ResetPasswordViewModel extends ResetPasswordViewModelInputs with ResetPasswordViewModelOutputs {
  final StreamController<String> _emailIsValid =
      StreamController<String>.broadcast();
  String email = '';
  @override

  Stream<String?> get emailValidationStream => _emailIsValid.stream.map((email) => _emailValidation(email));
  Stream<bool> get isEmailValid => _emailIsValid.stream.map((email) => _emailValidation(email) == null);
  @override
  void setEmail( String email) {
    this.email = email;
    _emailIsValid.add(email);
  }

  String? _emailValidation(String email) {
    if (email.isEmpty) {
      return AppStrings.emailErrorEmpty;
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]{3,}@(gmail\.com|outlook\.com|icloud\.com)$',
    );
    return emailRegex.hasMatch(email) ? null : AppStrings.emailNotValid;
  }

  dispose() {
    _emailIsValid.close();
  }

}

abstract class ResetPasswordViewModelInputs {
  void setEmail(String email);
}

mixin ResetPasswordViewModelOutputs {
  Stream<String?> get emailValidationStream;
  Stream<bool> get isEmailValid;
}
