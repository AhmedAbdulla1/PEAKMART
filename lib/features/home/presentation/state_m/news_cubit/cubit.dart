import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/home/data/model/request/news_request.dart';
import 'package:peakmart/features/home/domain/entity/news_entity.dart';
import 'package:peakmart/features/home/domain/home_repo.dart';
import 'package:peakmart/features/home/presentation/state_m/news_cubit/state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());
  final HomeRepository homeRepository = instance<HomeRepository>();
  late NewsEntity data;

  int _currentIndex = 0;
  Timer? _timer;

  void fetchNews() async {
    emit(NewsLoading());
    Result<AppErrors, NewsEntity> result = await homeRepository.getNews(
      NewsRequest(page: 1, limit: 10),
    );

    result.pick(onData: (data) {
      print('data $data');
      this.data = data;
      emit(NewsLoaded(data));
      _startNewsDisplayCycle();
    }, onError: (error) {
      print('error $error');
      emit(NewsError(error));
    });

  }

  void _startNewsDisplayCycle() {
    if (data.news.isEmpty) return;
    _currentIndex = 0; // Reset index
    _showNextNewsWithTimer();
  }

  void _showNextNewsWithTimer() {
    if (_currentIndex < data.news.length) {
      final news = data.news[_currentIndex];
      emit(ShowNewNews(news));

      // Schedule to hide the news after `timeShow`
      _timer = Timer(const Duration(seconds: 10 + 5), () async {
        emit(HideNews());
        await Future.delayed(const Duration(
            seconds: 3)); // Delay of 1 second before showing the next news
        _currentIndex++;
        _showNextNewsWithTimer(); // Recursive call for the next news
      });
    } else {
      _currentIndex = 0; // Reset index if needed for looping
      emit(ShowNewNews(data.news[_currentIndex])); // All news displayed, hide the section
    }
  }

  void hideNewsSection() {
    _timer?.cancel(); // Cancel any ongoing timer
    emit(HideNews());
  }

  @override
  Future<void> close() {
    _timer?.cancel(); // Cancel timer when the cubit is closed
    return super.close();
  }
}