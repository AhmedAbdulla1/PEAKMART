//
import 'package:flutter/material.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/features/auth/presentation/views/login/login_view.dart';
import 'package:peakmart/features/auth/presentation/views/otp_verification/otp_verification.dart';
import 'package:peakmart/features/auth/presentation/views/reset_password/view.dart';
import 'package:peakmart/features/auth/presentation/views/sign_up/sign_up_view.dart';
import 'package:peakmart/features/main/main_view.dart';
import 'package:peakmart/features/onboarding/presentation/views/onboarding_view.dart';

class Routes {
  static const String splashScreen = "/";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case OnboardingView.routeName:
        return MaterialPageRoute(
          builder: (_) => const OnboardingView(),
        );
      case MainView.routeName:
        initHomeModule();
        return MaterialPageRoute(
          builder: (_) => MainView(),
        );
      case LogInView.routeName:
        initLoginModule();
        return MaterialPageRoute(
          builder: (_) => const LogInView(),
        );
      case SignUpView.routeName:
        return MaterialPageRoute(
          builder: (_) => const SignUpView(),
        );
      case OtpVerification.routeName:
        // final registerEntity = settings.arguments as RegisterEntity;
        return MaterialPageRoute(
          builder: (_) => const OtpVerification(),
        );

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
