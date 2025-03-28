import 'package:flutter/material.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import '../error_viewer.dart';
import 'errv_snack_bar_options.dart';

void showSnakBarBasedErrorType(
  BuildContext context,
  AppErrors error,
  VoidCallback callback, {
  ErrVSnackBarOptions errVSnackBarOptions = const ErrVSnackBarOptions(),
  required bool retryWhenNotAuthorized,

}) {
  error.mapOrNull(
    connectionError: (_) {
      ErrorViewer.showConnectionError(
        context,
        callback,
        errorViewerOptions: errVSnackBarOptions,
      );
    },
    internalServerError: (_) {
      ErrorViewer.showInternalServerError(
        context,
        callback,
        errorViewerOptions: errVSnackBarOptions,
      );
    },
    internalServerWithDataError: (error) {
      if (error.message == null) {
        ErrorViewer.showUnexpectedError(
          context,
          errorViewerOptions: errVSnackBarOptions,
          callback: callback,
        );
      } else {
        ErrorViewer.showCustomError(
          context,
          error.message!,
          errorViewerOptions: errVSnackBarOptions,
          callback: callback,
        );
      }
    },
    badRequestError: (error) {
      ErrorViewer.showBadRequestError(
        context,
        error.message,
        callback: callback,
        errorViewerOptions: errVSnackBarOptions,
      );
    },
    cancelError: (_) {
      ErrorViewer.showCancelError(
        context,
        callback,
        errorViewerOptions: errVSnackBarOptions,
      );
    },
    conflictError: (_) {
      ErrorViewer.showConflictError(
        context,
        errorViewerOptions: errVSnackBarOptions,
        callback: callback,
      );
    },
    customError: (error) {
      ErrorViewer.showCustomError(
        context,
        error.message,
        errorViewerOptions: errVSnackBarOptions,
        callback: callback,
      );
    },
    forbiddenError: (_) {
      ErrorViewer.showForbiddenError(
        context,
        errorViewerOptions: errVSnackBarOptions,
        callback: callback,
        retryWhenNotAuthorized: retryWhenNotAuthorized,
      );
    },
    formatError: (_) {
      ErrorViewer.showFormatError(
        context,
        callback,
        errorViewerOptions: errVSnackBarOptions,
      );
    },
    loginRequiredError: (_) {
      ErrorViewer.showCustomError(
        context,
        'Login Required',
        errorViewerOptions: errVSnackBarOptions,
      );
    },
    netError: (_) {
      ErrorViewer.showConnectionError(
        context,
        callback,
        errorViewerOptions: errVSnackBarOptions,
      );
    },
    notFoundError: (error) {
      ErrorViewer.showNotFoundError(
        context,
        errorViewerOptions: errVSnackBarOptions,
        callback: callback,
        url: error.requestedUrlPath,
      );
    },
    responseError: (_) {
      ErrorViewer.showCustomError(
        context,
        "An error aquire in response",
        errorViewerOptions: errVSnackBarOptions,
      );
    },
    screenNotImplementedError: (_) {
      ErrorViewer.showCustomError(
        context,
        "match Not ImplementedError",
        errorViewerOptions: errVSnackBarOptions,
      );
    },
    socketError: (_) {
      ErrorViewer.showSocketError(
        context,
        callback,
        errorViewerOptions: errVSnackBarOptions,
      );
    },
    timeoutError: (_) {
      ErrorViewer.showTimeoutError(
        context,
        errorViewerOptions: errVSnackBarOptions,
        callback: callback,
      );
    },
    unauthorizedError: (_) {
      ErrorViewer.showUnauthorizedError(
        context,
        errorViewerOptions: errVSnackBarOptions,
        callback: callback,
        retryWhenNotAuthorized: retryWhenNotAuthorized
      );
    },
    unknownError: (_) {
      ErrorViewer.showUnknownError(
        context,
        errorViewerOptions: errVSnackBarOptions,
        callback: callback,
      );
    },
  );
}
