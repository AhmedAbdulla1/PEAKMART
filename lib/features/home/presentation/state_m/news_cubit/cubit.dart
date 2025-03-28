import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/features/home/domain/models/news_model.dart';
import 'package:peakmart/features/home/presentation/state_m/news_cubit/state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  final List<NewsModel> _newsList = [];
  int _currentIndex = 0;
  Timer? _timer;

  void fetchNews() async {
    try {
      emit(NewsLoading());
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      _newsList.addAll([
        NewsModel(
          timeShow: 25,
          link: 'https://google.com',
          description: 'Description for News Item 1 Description for News Item 1',
        ),
        NewsModel(
          timeShow: 30,
          link: 'https://example.com',
          description: 'Description for News Item 2 Description for News Item 2',
        ),
        NewsModel(
          timeShow: 20,
          link: 'https://another.com',
          description: 'Description for News Item 3 Description for News Item 3',
        ),
      ]);
      emit(NewsLoaded(_newsList));
      _startNewsDisplayCycle();
    } catch (e) {
      emit(NewsError("Failed to load news data"));
    }
  }

  void _startNewsDisplayCycle() {
    if (_newsList.isEmpty) return;
    _currentIndex = 0; // Reset index
    _showNextNewsWithTimer();
  }

  void _showNextNewsWithTimer() {
    if (_currentIndex < _newsList.length) {
      final news = _newsList[_currentIndex];
      emit(ShowNewNews(news));

      // Schedule to hide the news after `timeShow`
      _timer = Timer(Duration(seconds: news.timeShow+5), () async {
        emit(HideNews());
        await Future.delayed(Duration(seconds: 3)); // Delay of 1 second before showing the next news
        _currentIndex++;
        _showNextNewsWithTimer(); // Recursive call for the next news
      });
    } else {
      _currentIndex = 0; // Reset index if needed for looping
      emit(HideNews()); // All news displayed, hide the section
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
