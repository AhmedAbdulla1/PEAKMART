import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/features/home/domain/entity/content_entity.dart';

abstract class ContentState {}

class ContentInitial extends ContentState {}

class ContentLoading extends ContentState {}

class ContentLoaded extends ContentState {
  final ContentEntity contentEntity;

  ContentLoaded(this.contentEntity);
}

class ContentError extends ContentState {
  final AppErrors errors;
  // final VoidCallback onRetry;

  ContentError(
    this.errors,
  );
}
