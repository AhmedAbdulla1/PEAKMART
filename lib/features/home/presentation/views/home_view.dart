import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/features/home/presentation/state_m/news_cubit/cubit.dart';
import 'package:peakmart/features/home/presentation/state_m/news_cubit/state.dart';
import 'package:peakmart/features/home/presentation/views/home_view_body.dart';
import 'package:peakmart/features/home/presentation/views/news_section/news_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const String routeName = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // final List<BidWorkNowData> bids = [
  // const BidCardModel(
  //   title: 'The Luxe Houndstooth Lounge Chair',
  //   image: 'assets/images/card.png',
  //   subTitle: 'Auction End Date: November 1, 2024',
  //   price: '\$250',
  // ),
  // const BidCardModel(
  //   title: 'The Luxe Houndstooth Lounge Chair',
  //   image: 'assets/images/card.png',
  //   subTitle: 'Auction End Date: November 1, 2024',
  //   price: '\$300',
  // ),
  // const BidCardModel(
  //   title: 'The Luxe Houndstooth Lounge Chair',
  //   image: 'assets/images/card.png',
  //   subTitle: 'Auction End Date: November 1, 2024',
  //   price: '\$350',
  // ),
  // const BidCardModel(
  //   title: 'The Luxe Houndstooth Lounge Chair',
  //   image: 'assets/images/card.png',
  //   subTitle: 'Auction End Date: November 1, 2024',
  //   price: '\$400',
  // ),
  // const BidCardModel(
  //   title: 'The Luxe Houndstooth Lounge Chair',
  //   image: 'assets/images/card.png',
  //   subTitle: 'Auction End Date: November 1, 2024',
  //   price: '\$450',
  // ),
  // const BidCardModel(
  //   title: 'The Luxe Houndstooth Lounge Chair',
  //   image: 'assets/images/card.png',
  //   subTitle: 'Auction End Date: November 1, 2024',
  //   price: '\$500',
  // ),
  // ];
  // final List<EndedBidsData> myList =
  //     BlocProvider.of<EndedBidsCubit>(context).endedBidsData;
  // final List<EndedBidsData> endedBids = [
  //   const EndedBidsCardModel(
  //     title: 'The Luxe Houndstooth Lounge Chair',
  //     image: 'assets/images/card.png',
  //     price: '\$250',
  //   ),
  //   const EndedBidsCardModel(
  //     title: 'The Luxe Houndstooth Lounge Chair',
  //     image: 'assets/images/card.png',
  //     price: '\$300',
  //   ),
  //   const EndedBidsCardModel(
  //     title: 'The Luxe Houndstooth Lounge Chair',
  //     image: 'assets/images/card.png',
  //     price: '\$350',
  //   ),
  //   const EndedBidsCardModel(
  //     title: 'The Luxe Houndstooth Lounge Chair',
  //     image: 'assets/images/card.png',
  //     price: '\$400',
  //   ),
  //   const EndedBidsCardModel(
  //     title: 'The Luxe Houndstooth Lounge Chair',
  //     image: 'assets/images/card.png',
  //     price: '\$450',
  //   ),
  //   const EndedBidsCardModel(
  //     title: 'The Luxe Houndstooth Lounge Chair',
  //     image: 'assets/images/card.png',
  //     price: '\$500',
  //   ),
  // ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const HomeViewBody(),
        BlocProvider(
          create: (_) => NewsCubit()..fetchNews(),
          child: BlocBuilder<NewsCubit, NewsState>(
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
        ),
      ],
    );
  }
}
