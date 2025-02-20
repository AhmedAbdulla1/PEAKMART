import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:peakmart/core/constants/enums/http_method.dart';
import 'package:peakmart/core/data_source/remote_data_source.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/net/api_url.dart';
import 'package:peakmart/core/net/response_validators/default_response_validator.dart';
import 'package:peakmart/features/home/data/model/request/news_request.dart';
import 'package:peakmart/features/home/data/model/response/bid_work_now_response.dart';
import 'package:peakmart/features/home/data/model/response/content_response.dart';
import 'package:peakmart/features/home/data/model/response/ended_bids_response.dart';
import 'package:peakmart/features/home/data/model/response/future_bids_response.dart';
import 'package:peakmart/features/home/data/model/response/news_response.dart';
import 'package:peakmart/features/home/data/model/response/trending_bids_response.dart';

class HomeDataSource extends RemoteDataSource {
  Future<Either<AppErrors, NewsResponse>> getNews(
      NewsRequest newsRequest) async {
    return request<NewsResponse>(
        method: HttpMethod.GET,
        queryParameters: newsRequest.toJson(),
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          print('getNews at convert');
          print(json);
          return NewsResponse.fromJson(json);
        },
        url: APIUrls.getNews);
  }

  Future<Either<AppErrors, ContentResponse>> getContent() async {
    return request<ContentResponse>(
        method: HttpMethod.GET,
        queryParameters: {'page': 1, 'limit': 12},
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          return ContentResponse.fromJson(json);
        },
        url: APIUrls.getContent);
  }

  Future<Either<AppErrors, BidWorkNowResponse>> getBidWorkNow() async {
    return request<BidWorkNowResponse>(
        method: HttpMethod.GET,
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          log("message done in getBidWorkNow request");
          log("json is $json");
          return BidWorkNowResponse.fromJson(json);
        },
        url: APIUrls.getEndedBids);
  }

  Future<Either<AppErrors, EndedBidsResponse>> getEndedBids() async {
    return request<EndedBidsResponse>(
        method: HttpMethod.GET,
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          log("message done in ended bids request");
          return EndedBidsResponse.fromJson(json);
        },
        url: APIUrls.getEndedBids);
  }

  Future<Either<AppErrors, FutureBidsResponse>> getFutureBids() async {
    return request<FutureBidsResponse>(
        method: HttpMethod.GET,
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          log("message done in Future bids request");
          return FutureBidsResponse.fromJson(json);
        },
        url: APIUrls.getFutureBids);
  }

  Future<Either<AppErrors, TrendingBidsResponse>> getTrendingBids() async {
    return request<TrendingBidsResponse>(
        method: HttpMethod.GET,
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          log("message done in Trending bids request");
          return TrendingBidsResponse.fromJson(json);
        },
        url: APIUrls.getFutureBids);
  }
}
