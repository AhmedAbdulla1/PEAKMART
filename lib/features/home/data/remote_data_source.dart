import 'package:dartz/dartz.dart';
import 'package:peakmart/core/constants/enums/http_method.dart';
import 'package:peakmart/core/data_source/remote_data_source.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/net/api_url.dart';
import 'package:peakmart/core/net/response_validators/default_response_validator.dart';
import 'package:peakmart/features/home/data/model/request/news_request.dart';
import 'package:peakmart/features/home/data/model/response/news_response.dart';

class HomeDataSource extends RemoteDataSource {
  Future<Either<AppErrors, NewsResponse>> getNews(
      NewsRequest newsRequest) async {
    return request<NewsResponse>(
        method: HttpMethod.GET,
        queryParameters: newsRequest.toJson(),
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          return NewsResponse.fromJson(json);
        },
        url: APIUrls.getNews);
  }
}
