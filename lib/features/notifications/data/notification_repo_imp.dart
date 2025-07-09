// lib/features/notifications/data/notification_repo_imp.dart
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/app/network_info.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/responses/emty_response.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/core/entities/empty_entity.dart';
import 'package:peakmart/features/notifications/data/models/requests/request.dart';
import 'package:peakmart/features/notifications/data/models/responses/response.dart';
import 'package:peakmart/features/notifications/data/notification_data_source.dart';
import 'package:peakmart/features/notifications/domain/notification_enitity.dart';
import 'package:peakmart/features/notifications/domain/notification_repository.dart';

class NotificationRepoImp implements NotificationRepo {

  final NotificationsDataSource dataSource = NotificationsDataSource();
  final NetWorkInfo _networkInfo = instance<NetWorkInfo>();


  @override
  /// Fetches notifications for the user.
  ///
  /// This function checks the network connection and attempts to
  /// retrieve notifications from the remote data source. If the device
  /// is connected to the internet, it fetches notifications and
  /// converts the response into a `NotificationsEntity`. If an error
  /// occurs during the fetch, an appropriate `AppErrors` is returned.
  /// In case of no internet connection, a connection error is returned.
  ///
  /// Returns a [Result] containing either [AppErrors] or
  /// [NotificationsEntity].


  Future<Result<AppErrors, NotificationsEntity>> getNotifications() async {
    Result<AppErrors, NotificationsEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, NotificationsResponse> response =
            await dataSource.getNotifications();
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
  /// Updates a notification for the user.
  ///
  /// This function checks the network connection and attempts to
  /// update a notification with the remote data source. If the device
  /// is connected to the internet, it updates the notification and
  /// returns an [EmptyEntity] indicating success. If an error
  /// occurs during the update, an appropriate `AppErrors` is returned.
  /// In case of no internet connection, a connection error is returned.
  ///
  /// Returns a [Result] containing either [AppErrors] or
  /// [EmptyEntity].
  Future<Result<AppErrors, EmptyEntity>> updateNotification({
    required NotificationRequest notificationRequest,
  }) async {
    Result<AppErrors, EmptyEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, EmptyResponse> response =
        await dataSource.updateNotification(notificationRequest);
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
  Future<Result<AppErrors, EmptyEntity>> deleteNotification({
    required NotificationRequest notificationRequest,
  }) async {
    Result<AppErrors, EmptyEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, EmptyResponse> response =
            await dataSource.deleteNotification(notificationRequest);
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
