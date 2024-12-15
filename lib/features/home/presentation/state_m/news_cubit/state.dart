import 'package:peakmart/features/home/domain/models/news_model.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsModel> data;
  NewsLoaded(this.data);
}

class NewsError extends NewsState {
  final String message;
  NewsError(this.message);
}

class ShowNewNews extends NewsState {
  final NewsModel newsModel;
  ShowNewNews(this.newsModel);

}

class HideNews extends NewsState {}
