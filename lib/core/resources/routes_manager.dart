//
import 'package:flutter/material.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/features/auth/presentation/views/login/login_view.dart';
import 'package:peakmart/features/auth/presentation/views/otp_verification/otp_verification.dart';
import 'package:peakmart/features/auth/presentation/views/reset_password/view.dart';
import 'package:peakmart/features/auth/presentation/views/sign_up/sign_up_view.dart';
import 'package:peakmart/features/auth/presentation/views/signup_for_bid/view.dart';
import 'package:peakmart/features/bid_owner/data/models/request/add_product_request.dart';
import 'package:peakmart/features/bid_owner/presentation/views/add_product_details.dart';
import 'package:peakmart/features/bid_owner/presentation/views/bid_owner_view.dart';
import 'package:peakmart/features/main/main_view.dart';
import 'package:peakmart/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:peakmart/features/products/data/models/product_model.dart';
import 'package:peakmart/features/products/presentation/views/auction_rules_view.dart';
import 'package:peakmart/features/products/presentation/views/privacy_and_policy_view.dart';
import 'package:peakmart/features/products/presentation/views/product_details/product_details.dart';

final AppPreferences _appPreferences = instance<AppPreferences>();

class Routes {
  static const String root = "/";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.root:
        if (!_appPreferences.isPressKeyOnBoardingScreen()) {
          return MaterialPageRoute(builder: (_) => const OnboardingView());
        } else if (_appPreferences.isPressKeyLoginScreen()) {
          initHomeModule();
          return MaterialPageRoute(builder: (_) => const MainView());
        } else {
          initLoginModule();
          return MaterialPageRoute(builder: (_) => const LogInView());
        }
      case OnboardingView.routeName:
        return MaterialPageRoute(
          builder: (_) => const OnboardingView(),
        );
      case MainView.routeName:
        initHomeModule();
        return MaterialPageRoute(
          builder: (_) => const MainView(),
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
          builder: (_) => OtpVerification(
            verificationType: settings.arguments as VerificationType,
          ),
        );

      case ForgotPasswordView.routeName:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case SignUpForBidView.routeName:
        return MaterialPageRoute(builder: (_) => const SignUpForBidView());

      case BidOwnerView.routeName:
        initBidOwnerModule();
        return MaterialPageRoute(builder: (_) => const BidOwnerView());
      case AddProductDetails.routeName:
        return MaterialPageRoute(
            builder: (_) => AddProductDetails(
                  addProductRequest: settings.arguments as AddProductRequest,
                ));
      case PrivacyAndPolicyView.routeName:
        return MaterialPageRoute(builder: (_) => const PrivacyAndPolicyView());
      case AuctionRulesView.routeName:
        return MaterialPageRoute(builder: (_) => const AuctionRulesView());
      case ProductDetails.routeName:
        return MaterialPageRoute(
            builder: (_) => ProductDetails(
                  product: settings.arguments as Product,
                ));
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
