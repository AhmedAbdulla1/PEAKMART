import 'package:flutter/material.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/features/home/domain/entity/content_entity.dart';

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

  ContentError(this.errors, );
}