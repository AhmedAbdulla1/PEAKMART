//
import 'package:flutter/material.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/features/auth/presentation/views/login/login_view.dart';
import 'package:peakmart/features/auth/presentation/views/otp_verification/otp_verification.dart';
import 'package:peakmart/features/auth/presentation/views/reset_password/view.dart';
import 'package:peakmart/features/auth/presentation/views/sign_up/sign_up_view.dart';
import 'package:peakmart/features/auth/presentation/views/signup_for_bid/view.dart';
import 'package:peakmart/features/auth/presentation/views/signup_for_bid/hold_screen.dart';
import 'package:peakmart/features/bid_owner/data/models/request/add_product_request.dart';
import 'package:peakmart/features/bid_owner/presentation/views/add_product_details.dart';
import 'package:peakmart/features/bid_owner/presentation/views/bid_owner_view.dart';
import 'package:peakmart/features/main/main_view.dart';
import 'package:peakmart/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:peakmart/features/products/presentation/views/auction_rules_view.dart';
import 'package:peakmart/features/products/presentation/views/privacy_and_policy_view.dart';
import 'package:peakmart/features/products/presentation/views/product_details/product_details.dart';
import 'package:peakmart/features/products/presentation/views/random_products/random_products_view.dart';
import 'package:peakmart/features/profile/presentation/views/personal_inof/personal_inof_screen.dart';
import 'package:peakmart/features/profile/presentation/views/settings/settings_view.dart';
import 'package:peakmart/features/profile/presentation/views/user_products/cart_view.dart';

final AppPreferences _appPreferences = instance<AppPreferences>();

class Routes {
  static const String root = "/";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.root:
        if (!_appPreferences.isPressKeyOnBoardingScreen()) {
          return MaterialPageRoute(
            builder: (_) => const OnboardingView(),
            settings: const RouteSettings(name: Routes.root),
          );
        } else if (_appPreferences.isPressKeyLoginScreen()) {
          initHomeModule();
          return MaterialPageRoute(
            builder: (_) => const MainView(),
            settings: const RouteSettings(name: Routes.root),
          );
        } else {
          initLoginModule();
          return MaterialPageRoute(
            builder: (_) => const LogInView(),
            settings: const RouteSettings(name: Routes.root),
          );
        }
      case OnboardingView.routeName:
        return MaterialPageRoute(
          builder: (_) => const OnboardingView(),
          settings: const RouteSettings(name: OnboardingView.routeName),
        );
      case MainView.routeName:
        initHomeModule();
        return MaterialPageRoute(
          builder: (_) => const MainView(),
          settings: const RouteSettings(name: MainView.routeName),
        );
      case LogInView.routeName:
        initLoginModule();
        return MaterialPageRoute(
          builder: (_) => const LogInView(),
          settings: const RouteSettings(name: LogInView.routeName),
        );
      case SignUpView.routeName:
        return MaterialPageRoute(
          builder: (_) => const SignUpView(),
          settings: const RouteSettings(name: SignUpView.routeName),
        );
      case OtpVerification.routeName:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) =>
              OtpVerification(
                verificationType: args['verificationType'] as VerificationType,
                registerEntity: args['registerEntity'],
                autoSendOtp: args['autoSendOtp'] ?? false,
              ),
          settings: const RouteSettings(name: OtpVerification.routeName),
        );
      case ForgotPasswordView.routeName:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordView(),
          settings: const RouteSettings(name: ForgotPasswordView.routeName),
        );
      case SignUpForBidView.routeName:
        int indexScreen = settings.arguments == null ? 0 : settings
            .arguments as int;
        return MaterialPageRoute(
          builder: (_) => SignUpForBidView(indexScreen: indexScreen),
          settings: const RouteSettings(name: SignUpForBidView.routeName),
        );
      case BidOwnerView.routeName:
        initBidOwnerModule();
        return MaterialPageRoute(
          builder: (_) => const BidOwnerView(),
          settings: const RouteSettings(name: BidOwnerView.routeName),
        );
      case AddProductDetails.routeName:
        return MaterialPageRoute(
          builder: (_) =>
              AddProductDetails(
                addProductRequest: settings.arguments as AddProductRequest,
              ),
          settings: const RouteSettings(name: AddProductDetails.routeName),
        );
      case RandomProductsView.routeName:
        final args = settings.arguments as List<ProductEntity>;
        return MaterialPageRoute(
          builder: (_) =>
              RandomProductsView(
                allProducts: args,
              ),
          settings: const RouteSettings(name: RandomProductsView.routeName),
        );
      case PrivacyAndPolicyView.routeName:
        return MaterialPageRoute(
          builder: (_) => const PrivacyAndPolicyView(),
          settings: const RouteSettings(name: PrivacyAndPolicyView.routeName),
        );
      case AuctionRulesView.routeName:
        return MaterialPageRoute(
          builder: (_) => const AuctionRulesView(),
          settings: const RouteSettings(name: AuctionRulesView.routeName),
        );
      case UserProductsView.routeName:
        return MaterialPageRoute(
          builder: (_) => const UserProductsView(),
          settings: const RouteSettings(name: UserProductsView.routeName),
        );
      case ProductDetails.routeName:
        return MaterialPageRoute(
          builder: (_) =>
              ProductDetails(
                product: settings.arguments as ProductEntity,
              ),
          settings: const RouteSettings(name: ProductDetails.routeName),
        );
      case HoldScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const HoldScreen(),
          settings: const RouteSettings(name: HoldScreen.routeName),
        );

      case PersonalInformationScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const PersonalInformationScreen(),
          settings: const RouteSettings(
              name: PersonalInformationScreen.routeName),
        ); 
        
        case SettingsView.routeName:
        return MaterialPageRoute(
          builder: (_) => const SettingsView(),
          settings: const RouteSettings(
              name: SettingsView.routeName),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
          const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
          settings: const RouteSettings(name: 'undefined'),
        );
    }
  }

  static Route unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) =>
          Scaffold(
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
