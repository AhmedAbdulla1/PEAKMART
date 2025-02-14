import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/features/home/presentation/state_m/content_cubit/cubit.dart';
import 'package:peakmart/features/home/presentation/state_m/news_cubit/cubit.dart';
import 'package:peakmart/features/home/presentation/state_m/news_cubit/state.dart';
import 'package:peakmart/features/home/presentation/views/apply_section/apply_view.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/bid_card_model.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/ended_bids_card_model.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/titled_bid_section.dart';
import 'package:peakmart/features/home/presentation/views/category_section/catrgory_view.dart';
import 'package:peakmart/features/home/presentation/views/landing_section/landing_view.dart';
import 'package:peakmart/features/home/presentation/views/news_section/news_view.dart';
import 'package:peakmart/features/home/presentation/views/offers_section/offers_view.dart';
import 'package:peakmart/features/home/presentation/views/partners_section/partners_view.dart';
import 'package:peakmart/features/home/presentation/views/services_section/services_section.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  static const String routeName = '/home';

  final List<BidCardModel> bids = [
    const BidCardModel(
      title: 'The Luxe Houndstooth Lounge Chair',
      image: 'assets/images/card.png',
      subTitle: 'Auction End Date: November 1, 2024',
      price: '\$250',
    ),
    const BidCardModel(
      title: 'The Luxe Houndstooth Lounge Chair',
      image: 'assets/images/card.png',
      subTitle: 'Auction End Date: November 1, 2024',
      price: '\$300',
    ),
    const BidCardModel(
      title: 'The Luxe Houndstooth Lounge Chair',
      image: 'assets/images/card.png',
      subTitle: 'Auction End Date: November 1, 2024',
      price: '\$350',
    ),
    const BidCardModel(
      title: 'The Luxe Houndstooth Lounge Chair',
      image: 'assets/images/card.png',
      subTitle: 'Auction End Date: November 1, 2024',
      price: '\$400',
    ),
    const BidCardModel(
      title: 'The Luxe Houndstooth Lounge Chair',
      image: 'assets/images/card.png',
      subTitle: 'Auction End Date: November 1, 2024',
      price: '\$450',
    ),
    const BidCardModel(
      title: 'The Luxe Houndstooth Lounge Chair',
      image: 'assets/images/card.png',
      subTitle: 'Auction End Date: November 1, 2024',
      price: '\$500',
    ),
  ];
  final List<EndedBidsCardModel> endedBids = [
    const EndedBidsCardModel(
      title: 'The Luxe Houndstooth Lounge Chair',
      image: 'assets/images/card.png',
      price: '\$250',
    ),
    const EndedBidsCardModel(
      title: 'The Luxe Houndstooth Lounge Chair',
      image: 'assets/images/card.png',
      price: '\$300',
    ),
    const EndedBidsCardModel(
      title: 'The Luxe Houndstooth Lounge Chair',
      image: 'assets/images/card.png',
      price: '\$350',
    ),
    const EndedBidsCardModel(
      title: 'The Luxe Houndstooth Lounge Chair',
      image: 'assets/images/card.png',
      price: '\$400',
    ),
    const EndedBidsCardModel(
      title: 'The Luxe Houndstooth Lounge Chair',
      image: 'assets/images/card.png',
      price: '\$450',
    ),
    const EndedBidsCardModel(
      title: 'The Luxe Houndstooth Lounge Chair',
      image: 'assets/images/card.png',
      price: '\$500',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ContentCubit()..getContent()),
        BlocProvider(create: (context) => NewsCubit()..fetchNews()),
      ],
      child: Stack(
        children: [
          ListView(children: [
            const SizedBox(
              height: AppSize.s40,
            ),
            LandingView(),
            const ServicesSection(),
            TitledBidSection(
              title: AppStrings.trendingBids,
              bids: bids,
              endedBids: const [],
            ),
            const SizedBox(
              height: AppSize.s12,
            ),
            TitledBidSection(
              title: AppStrings.futureBids,
              bids: bids,
              endedBids: const [],
            ),
            const SizedBox(
              height: AppSize.s12,
            ),
             OfferSView(),
            const SizedBox(
              height: AppSize.s12,
            ),
            CategorySection(),
            const SizedBox(
              height: AppSize.s12,
            ),
            TitledBidSection(
              title: AppStrings.bidsWorkNow,
              endedBids: const [],
              bids: bids,
            ),
            const SizedBox(
              height: AppSize.s12,
            ),
            TitledBidSection(
              title: AppStrings.endedBids,
              endedBids: endedBids,
              bids: const [],
              isEnded: true,
            ),
            const SizedBox(
              height: AppSize.s12,
            ),
             ApplyView(),
            const SizedBox(
              height: AppSize.s12,
            ),
             PartnersView(),
            const SizedBox(
              height: AppSize.s12,
            ),
          ]),
          BlocBuilder<NewsCubit, NewsState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (state is ShowNewNews) ...[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: AnimatedNewsContainer(
                          newsModel: state.newsModel,
                          windowSize: MediaQuery.of(context).size,
                        ),
                      ),
                    ), // Your dynamic widget
                    const SizedBox(height: 20),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
