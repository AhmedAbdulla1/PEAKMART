import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:peakmart/app/app_prefs.dart' show AppPreferences;
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/constants/enums/http_method.dart';
import 'package:peakmart/core/data_source/remote_data_source.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/net/api_url.dart';
import 'package:peakmart/core/net/response_validators/default_response_validator.dart';
import 'package:peakmart/core/net/response_validators/response_validator.dart';
import 'package:peakmart/core/responses/emty_response.dart';
import 'package:peakmart/features/notifications/data/models/requests/request.dart';
import 'package:peakmart/features/notifications/data/models/responses/response.dart';
import 'package:peakmart/features/products/data/models/request/pagination_request.dart';
import 'package:peakmart/features/products/data/models/response/products_response.dart';

class NotificationsDataSource extends RemoteDataSource {
  Future<Either<AppErrors, NotificationsResponse>> getNotifications() async {
    return request<NotificationsResponse>(
        method: HttpMethod.POST,
        body: {
          "user_id": instance<AppPreferences>().getUserId(),
        },
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          log("json is $json");
          return NotificationsResponse.fromJson(json);
        },
        url: APIUrls.getNotifications);
  }

  Future<Either<AppErrors, EmptyResponse>> updateNotification(NotificationRequest notification) async {
    return request<EmptyResponse>(
        method: HttpMethod.POST,
        body: notification.toJson(),
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          return EmptyResponse.fromJson(json);
        },
        url: APIUrls.updateNotification);
  }
  Future<Either<AppErrors, EmptyResponse>> deleteNotification(NotificationRequest notification) async {
    return request<EmptyResponse>(
        method: HttpMethod.POST,
        body: notification.toJson(),
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          return EmptyResponse.fromJson(json);
        },
        url: APIUrls.deleteNotification);
  }
}

