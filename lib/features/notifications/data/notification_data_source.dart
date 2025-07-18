import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:Bid_Mart/app/app_prefs.dart' show AppPreferences;
import 'package:Bid_Mart/app/di.dart';
import 'package:Bid_Mart/core/constants/enums/http_method.dart';
import 'package:Bid_Mart/core/data_source/remote_data_source.dart';
import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/core/net/api_url.dart';
import 'package:Bid_Mart/core/net/response_validators/default_response_validator.dart';
import 'package:Bid_Mart/core/responses/emty_response.dart';
import 'package:Bid_Mart/features/notifications/data/models/requests/request.dart';
import 'package:Bid_Mart/features/notifications/data/models/responses/response.dart';

class NotificationsDataSource extends RemoteDataSource {
  Future<Either<AppErrors, NotificationsResponse>> getNotifications() async {
    return request<NotificationsResponse>(
        method:  HttpMethod.post,
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
        method:  HttpMethod.post,
        body: notification.toJson(),
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          return EmptyResponse.fromJson(json);
        },
        url: APIUrls.updateNotification);
  }
  Future<Either<AppErrors, EmptyResponse>> deleteNotification(NotificationRequest notification) async {
    return request<EmptyResponse>(
        method:  HttpMethod.post,
        body: notification.toJson(),
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          return EmptyResponse.fromJson(json);
        },
        url: APIUrls.deleteNotification);
  }
}

