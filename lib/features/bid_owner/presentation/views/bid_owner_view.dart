import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/auth/presentation/views/otp_verification/otp_verification.dart';
import 'package:peakmart/features/auth/presentation/views/signup_for_bid/hold_screen.dart';
import 'package:peakmart/features/auth/presentation/views/signup_for_bid/view.dart';
import 'package:peakmart/features/bid_owner/presentation/state_mang/add_product_cubit/add_product_cubit.dart';
import 'package:peakmart/features/bid_owner/presentation/state_mang/add_product_cubit/image_picker_controller.dart';
import 'package:peakmart/features/bid_owner/presentation/views/widgets/add_product_view_body.dart';
import 'package:provider/provider.dart';

class BidOwnerView extends StatefulWidget {
  const BidOwnerView({super.key});

  static const routeName = "/bid_owner";

  @override
  State<BidOwnerView> createState() => _BidOwnerViewState();
}

class _BidOwnerViewState extends State<BidOwnerView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ImagePickerController(),
      child: SafeArea(
        child: BlocProvider(
          create: (context) => AddProductCubit()
            ..getCategories()
            ..checkIsASeller(),
          child: BlocBuilder<AddProductCubit, AddProductState>(
              builder: (context, state) {
            switch (state.runtimeType) {
              case const (NotVerifiedState):
                return const NotVerifiedSeller();
              case const (NotASellerState):
                return const NotASeller();
              case const (NotActivatedState):
                return const HoldScreen(
                  showBackButton: false,
                );
              case const (NotCompleteState):
                return const CompleteInfo();
              case const (ActivatedState):
                return const AddProductViewBody();
              default:
                return const WaitingWidget();
            }
          }),
        ),
      ),
    );
  }
}

class NotVerifiedSeller extends StatelessWidget {
  const NotVerifiedSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "You are not a verified  seller\n Please verify your account",
              style: TextStyle(fontSize: FontSize.s22),
            ),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          SizedBox(
            width: 250,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, OtpVerification.routeName,
                    arguments: {"verificationType": VerificationType.watsApp});
              },
              child: const Text(
                "Verify Now",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NotASeller extends StatelessWidget {
  const NotASeller({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "You are not a seller",
              style: TextStyle(fontSize: FontSize.s22),
            ),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          SizedBox(
            width: 250,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, SignUpForBidView.routeName,
                    arguments: 0);
              },
              child: const Text(
                "Join Now",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CompleteInfo extends StatelessWidget {
  const CompleteInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Complete your information",
              style: TextStyle(fontSize: FontSize.s22),
            ),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          SizedBox(
            width: 250,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, SignUpForBidView.routeName,
                    arguments: 1);
              },
              child: const Text(
                "Join Now",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
