import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/app/network_info.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/home/data/model/request/news_request.dart';
import 'package:peakmart/features/home/data/model/response/ended_bids_response.dart';
import 'package:peakmart/features/home/data/model/response/news_response.dart';
import 'package:peakmart/features/home/data/remote_data_source.dart';
import 'package:peakmart/features/home/domain/entity/ended_bids_entity.dart';
import 'package:peakmart/features/home/domain/entity/news_entity.dart';
import 'package:peakmart/features/home/domain/home_repo.dart';

class HomeRepositoryImp extends HomeRepository {
  final HomeDataSource _remoteDataSource = HomeDataSource();
  final NetWorkInfo _networkInfo = instance<NetWorkInfo>();

  @override
  Future<Result<AppErrors, NewsEntity>> getNews(NewsRequest newsResponse) async {
    Result<AppErrors, NewsEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, NewsResponse> response =
            await _remoteDataSource.getNews(newsResponse);
        result = response.fold((error) {
          return Result(error: error);
        }, (response) {
          return Result(data: response.toEntity());
        });
      } catch (error) {
        result = Result(error: const AppErrors.responseError());
      }
    } else {
      result = Result(error: const AppErrors.connectionError());
    }
    return result;
  }

  @override
  Future<Result<AppErrors, EndedBidsEntity>> getEndedBids() async {
    Result<AppErrors, EndedBidsEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, EndedBidsResponse> response =
            await _remoteDataSource.getEndedBids();
        result = response.fold((error) {
          return Result(error: error);
        }, (response) {
          return Result(data: response.toEntity());
        });
      } catch (error) {
        result = Result(error: const AppErrors.responseError());
      }
    } else {
      result = Result(error: const AppErrors.connectionError());
    }
    return result;
  }
}
