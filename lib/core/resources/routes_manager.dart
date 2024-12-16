//
import 'package:flutter/material.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/features/auth/domain/entity/register_entity.dart';
import 'package:peakmart/features/auth/presentation/views/login/login_view.dart';
import 'package:peakmart/features/auth/presentation/views/otp_verification/otp_verification.dart';
import 'package:peakmart/features/auth/presentation/views/reset_password/view.dart';
import 'package:peakmart/features/auth/presentation/views/sign_up/sign_up_view.dart';
import 'package:peakmart/features/main/main_view.dart';

class Routes {
  static const String splashScreen = "/";

  @deprecated
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
        initHomeModule();
        return MaterialPageRoute(builder: (_) => MainView());
      case MainView.routeName:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => MainView());
      case LogInView.routeName:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LogInView());
      case OtpVerification.routeName:
        // final registerEntity = settings.arguments as RegisterEntity;
        return MaterialPageRoute(
            builder: (_) => const OtpVerification(
                
                ));

      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case ForgotPasswordView.routeName:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());

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
