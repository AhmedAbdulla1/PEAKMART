//
import 'package:flutter/material.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/features/auth/presentation/views/reset_password/view_model.dart';
import 'package:peakmart/features/auth/presentation/views/reset_password/view.dart';
import 'package:peakmart/features/auth/presentation/views/otp_verification/otp_verification.dart';
import 'package:peakmart/features/auth/presentation/views/login/login_view.dart';
import 'package:peakmart/features/auth/presentation/views/sign_up/sign_up_view.dart';
import 'package:peakmart/features/main/main_view.dart';

class Routes {
  static const String splashScreen = "/";
  static const String mainScreen = "/mainScreen";
  static const String signInScreen = "/signInScreen";
  static const String signUpScreen = "/signUpScreen";
  static const String forgetPasswordScreen = "/forgetPasswordScreen";
  static const String otpVerification = "/otpVerification";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.mainScreen:
        return MaterialPageRoute(builder: (_) => MainView());
      case MainView.routeName:
        return MaterialPageRoute(builder: (_) => MainView());
      case LogInView.routeName:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LogInView());
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case ForgotPasswordView.routeName:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.otpVerification:
        return MaterialPageRoute(builder: (_) => const OtpVerification());
      default:
        return unDefinedRoute();

    }
  }

  static Route unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            AppStrings.noRouteFound,
          ),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
