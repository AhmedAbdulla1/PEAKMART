// import 'package:FireBox/app/di.dart';
// import 'package:FireBox/presentation/add_new_device/add_new_device_view.dart';
// import 'package:FireBox/presentation/add_new_trainee_screen/view.dart';
// import 'package:FireBox/presentation/exercises/view.dart';
// import 'package:FireBox/presentation/login_screen/view/login_view.dart';
// import 'package:FireBox/presentation/training_screen/in_training.dart';
//
// import 'package:FireBox/presentation/reset_password_screen/view/recover_password_view.dart';
// import 'package:FireBox/presentation/reset_password_screen/view/verify_code_view.dart';
//
// import 'package:FireBox/presentation/resources/string_manager.dart';
//
// import 'package:FireBox/presentation/signup_screen/view/signup_view.dart';
// import 'package:FireBox/presentation/trainees/view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import '../main_screen/main_view.dart';
// import '../profile_details_screen/view.dart';
//
import 'package:flutter/material.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/app/resources/string_manager.dart';
import 'package:peakmart/features/auth/presentation/views/reset_password/change_password.dart';
import 'package:peakmart/features/auth/presentation/views/reset_password/forget_password_view.dart';
import 'package:peakmart/features/auth/presentation/views/otp_verification/otp_verification.dart';
import 'package:peakmart/features/auth/presentation/views/sign_in/login_view.dart';
import 'package:peakmart/features/auth/presentation/views/sign_up/sign_up_view.dart';
import 'package:peakmart/features/main/main_view.dart';

import '../../features/home/presentation/views/home_view.dart';

class Routes {
  static const String splashScreen = "/";
  static const String mainScreen="/mainScreen";
  static const String signInScreen = "/signInScreen";
  static const String signUpScreen = "/signUpScreen";
  static const String forgetPasswordScreen = "/forgetPasswordScreen";
  static const String otpVerification = "/otpVerification";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {

      case Routes.mainScreen:
        return MaterialPageRoute(builder: (_) =>  MainView());
      case LogInView.routeName:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LogInView());
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case ForgotPasswordView.routeName:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.otpVerification:
        return MaterialPageRoute(builder: (_) => const OtpVerification());
      case ChangePasswordView.routeName:
        return MaterialPageRoute(builder: (_) => const ChangePasswordView());
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
