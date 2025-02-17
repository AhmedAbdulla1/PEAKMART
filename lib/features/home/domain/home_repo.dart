import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/home/data/model/request/news_request.dart';
import 'package:peakmart/features/home/domain/entity/bid_work_now_entity.dart';
import 'package:peakmart/features/home/domain/entity/ended_bids_entity.dart';
import 'package:peakmart/features/home/domain/entity/content_entity.dart';
import 'package:peakmart/features/home/domain/entity/future_bids_entity.dart';
import 'package:peakmart/features/home/domain/entity/news_entity.dart';

abstract class HomeRepository {
  Future<Result<AppErrors, NewsEntity>> getNews(NewsRequest newsResponse);
  Future<Result<AppErrors, EndedBidsEntity>> getEndedBids();
  Future<Result<AppErrors, BidWorkNowEntity>> getBidWorkNow();
  Future<Result<AppErrors, FutureBidsEntity>> getFutureBids();


  Future<Result<AppErrors, ContentEntity>> getContent();
}
