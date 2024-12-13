import 'dart:async';

import 'package:peakmart/core/resources/string_manager.dart';

class LoginViewModel extends LoginViewModelOutput {
  final StreamController<String> _emailStreamController =
      StreamController.broadcast();
  final StreamController<String> _passwordStreamController =
      StreamController.broadcast();
  String email = '', password = '';
  final StreamController<void> _areInputsValid = StreamController.broadcast();
  StreamController isUserLoginSuccessfullyStreamController =
      StreamController<bool>();

  void dispose() {
    _emailStreamController.close();
    _passwordStreamController.close();
    _areInputsValid.close();
    isUserLoginSuccessfullyStreamController.close();
  }

  @override
  setEmail(String email) {
    this.email = email;
    _emailStreamController.add(email);
    _areInputsValid.add(null);
  }

  @override
  setPassword(String password) {
    this.password = password;
    _passwordStreamController.add(password);
    _areInputsValid.add(null);
  }

  @override
  Stream<String?> get outEmailValidation => _emailStreamController.stream.map(
        (email) => _emailValidation(email),
      );

  @override
  Stream<String?> get outPasswordValidation =>
      _passwordStreamController.stream.map(
        (password) => _passwordValidation(password),
      );

  @override
  Stream<bool> get outAreInputsValid =>
      _areInputsValid.stream.map((_) => _areAllInputsValid());

  String? _emailValidation(String email) {
    if (email.isEmpty) {
      return AppStrings.emailErrorEmpty;
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]{3,}@(gmail\.com|outlook\.com|icloud\.com)$',
    );

    print(emailRegex.hasMatch(email));
    return emailRegex.hasMatch(email) ? null : AppStrings.emailNotValid;
  }

  String? _passwordValidation(String email) {
    if (email.isEmpty) {
      return AppStrings.passwordErrorEmpty;
    }
    return null;
  }

  bool _areAllInputsValid() {
    return _emailValidation(email) == null &&
        _passwordValidation(password) == null;
  }
}

abstract class LoginViewModelInput {
  setEmail(String email);

  setPassword(String password);
}

abstract class LoginViewModelOutput extends LoginViewModelInput {
  Stream<String?> get outEmailValidation;

  Stream<String?> get outPasswordValidation;

  Stream<bool> get outAreInputsValid;
}
