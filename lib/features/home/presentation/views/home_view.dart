
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/features/home/presentation/state_m/category_cubit/category_cubit.dart';
import 'package:peakmart/features/home/presentation/state_m/content_cubit/cubit.dart';
import 'package:peakmart/features/home/presentation/state_m/home_cubits/bid_work_now_cubit.dart';
import 'package:peakmart/features/home/presentation/state_m/home_cubits/ended_bids_cubit.dart';
import 'package:peakmart/features/home/presentation/state_m/home_cubits/future_bids_cubit.dart';
import 'package:peakmart/features/home/presentation/state_m/home_cubits/trending_bids_cubit.dart';
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
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ContentCubit()..getContent()),
        BlocProvider(create: (context) => NewsCubit()..fetchNews()),
        BlocProvider(create: (context) => FutureBidsCubit()..getFutureBids()),
        BlocProvider(create: (context) => BidWorkNowCubit()..getBidWorkNow()),
        BlocProvider(create: (context) => EndedBidsCubit()..getEndedBids()),
        BlocProvider(
            create: (context) => TrendingBidsCubit()..getTrendingBids()),
        BlocProvider(create: (context) => CategoryCubit()..getCategory()),
      ],
      child:  Stack(
        children: [
           HomeViewBody(),
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
