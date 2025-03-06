import 'package:flutter/material.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import '../error_viewer.dart';
import 'errv_toast_options.dart';

void showToastBasedErrorType(
  BuildContext context,
  AppErrors error,
  VoidCallback callback, {
  ErrVToastOptions errVToastOptions = const ErrVToastOptions(),
  required bool retryWhenNotAuthorized,
}) {
  error.mapOrNull(
    connectionError: (error) {
      ErrorViewer.showConnectionError(
        context,
        callback,
        errorViewerOptions: errVToastOptions,
      );
    },
    internalServerError: (_) {
      ErrorViewer.showInternalServerError(
        context,
        callback,
        errorViewerOptions: errVToastOptions,
      );
    },
    internalServerWithDataError: (error) {
      if (error.message == null) {
        ErrorViewer.showUnexpectedError(
          context,
          errorViewerOptions: errVToastOptions,
          callback: callback,
        );
      } else {
        ErrorViewer.showCustomError(
          context,
          error.message!,
          errorViewerOptions: errVToastOptions,
          callback: callback,
        );
      }
    },
    // accountNotVerifiedError: (_) {
    //   ErrorViewer.showAccountNotVerifiedError(
    //     context,
    //     callback,
    //     errorViewerOptions: errVToastOptions,
    //   );
    // },
    badRequestError: (error) {
      ErrorViewer.showBadRequestError(
        context,
        error.message,
        errorViewerOptions: errVToastOptions,
        callback: callback,
      );
    },
    cancelError: (_) {
      ErrorViewer.showCancelError(
        context,
        callback,
        errorViewerOptions: errVToastOptions,
      );
    },
    conflictError: (error) {
      ErrorViewer.showConflictError(
        context,
        errorViewerOptions: errVToastOptions,
        callback: callback,
        message: error.message,
      );
    },
    customError: (error) {
      ErrorViewer.showCustomError(
        context,
        error.message,
        errorViewerOptions: errVToastOptions,
        callback: callback,
      );
    },
    forbiddenError: (error) {
      ErrorViewer.showForbiddenError(
        context,
        message: error.message,
        errorViewerOptions: errVToastOptions,
        callback: callback,
        retryWhenNotAuthorized: retryWhenNotAuthorized,
      );
    },
    formatError: (_) {
      ErrorViewer.showFormatError(
        context,
        callback,
        errorViewerOptions: errVToastOptions,
      );
    },
    loginRequiredError: (_) {
      ErrorViewer.showCustomError(
        context,
        AppStrings.loginErrorRequired,
        errorViewerOptions: errVToastOptions,
      );
    },
    netError: (_) {
      ErrorViewer.showConnectionError(
        context,
        callback,
      );
    },
    notFoundError: (error) {
      ErrorViewer.showNotFoundError(
        context,
        errorViewerOptions: errVToastOptions,
        callback: callback,
        message: error.requestedUrlPath,
        url: error.requestedUrlPath,
      );
    },
    responseError: (_) {
      ErrorViewer.showCustomError(
        context,
        "An error acquire in response",
        errorViewerOptions: errVToastOptions,
      );
    },
    screenNotImplementedError: (_) {
      ErrorViewer.showCustomError(
        context,
        "match Not ImplementedError",
        errorViewerOptions: errVToastOptions,
      );
    },
    socketError: (_) {
      ErrorViewer.showSocketError(
        context,
        callback,
        errorViewerOptions: errVToastOptions,
      );
    },
    timeoutError: (_) {
      ErrorViewer.showTimeoutError(
        context,
        errorViewerOptions: errVToastOptions,
        callback: callback,
      );
    },
    unauthorizedError: (error) {
      ErrorViewer.showUnauthorizedError(
        context,
        errorViewerOptions: errVToastOptions,
        message: error.message,
        callback: callback,
        retryWhenNotAuthorized: retryWhenNotAuthorized,
      );
    },
    unknownError: (_) {
      ErrorViewer.showUnknownError(
        context,
        errorViewerOptions: errVToastOptions,
        callback: callback,
      );
    },
  );
}
