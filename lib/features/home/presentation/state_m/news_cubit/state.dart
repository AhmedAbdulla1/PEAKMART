import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/features/home/domain/entity/news_entity.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final NewsEntity data;

  NewsLoaded(this.data);
}

class NewsError extends NewsState {
  final AppErrors message;

  NewsError(this.message);
}

class ShowNewNews extends NewsState {
  final NewsData newsModel;

  ShowNewNews(this.newsModel);
}

class HideNews extends NewsState {}
