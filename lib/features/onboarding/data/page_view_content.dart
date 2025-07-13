import 'package:Bid_Mart/core/resources/assets_manager.dart';

import 'models/onboarding_model.dart';

List<OnboardingModel> onboardingList = [
  const OnboardingModel(
    image: ImageAssets.onBoardingPageOne,
    title: 'Explore Auctions',
    description:
        'Browse a wide range of live auctions across categories. Find products you love and track bids in real-time.',
  ),
  const OnboardingModel(
    image: ImageAssets.onBoardingPageTwo,
    title: 'Place Secure Bids',
    description:
        'Bid confidently with our secure and transparent bidding system. We ensure fair play and encrypted transactions.',
  ),
  const OnboardingModel(
    image: ImageAssets.onBoardingPageThree,
    title: 'Win & Pay Easily',
    description:
        'Once you win the auction, pay instantly through secure gateways. Enjoy a smooth and hassle-free checkout process.',
  ),
  const OnboardingModel(
    image: ImageAssets.onBoardingPageFour,
    title: 'Track & Receive',
    description:
        'Monitor your order status, delivery, and history from one place. Your product is on its way—fast and safe!',
  ),
];
