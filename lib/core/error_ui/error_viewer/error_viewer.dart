import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'dialog/errv_dialog_options.dart';
import 'dialog/show_dialog_based_error_type.dart';
import 'dialog/show_error_dialog.dart';
import 'errv_options.dart';
import 'snack_bar/errv_snack_bar_options.dart';
import 'snack_bar/show_error_snackbar.dart';
import 'snack_bar/show_snackbar_based_error_type.dart';
import 'toast/errv_toast_options.dart';
import 'toast/show_error_toast.dart';
import 'toast/show_toast_based_error_type.dart';

class ErrorViewer {
  static showError({
    required BuildContext context,
    required AppErrors error,
    required VoidCallback callback,
    ErrorViewerOptions errorViewerOptions = const ErrVToastOptions(),
    bool retryWhenNotAuthorized = true,
  }) {
    if (errorViewerOptions is ErrVSnackBarOptions) {
      showSnakBarBasedErrorType(
        context,
        error,
        callback,
        errVSnackBarOptions: errorViewerOptions,
        retryWhenNotAuthorized: retryWhenNotAuthorized,
      );
    } else if (errorViewerOptions is ErrVToastOptions) {
      showToastBasedErrorType(
        context,
        error,
        callback,
        errVToastOptions: errorViewerOptions,
        retryWhenNotAuthorized: retryWhenNotAuthorized
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showDialogBasedErrorType(
        context,
        error,
        callback,
        errVDialogOptions: errorViewerOptions,
        retryWhenNotAuthorized: retryWhenNotAuthorized,
      );
    }
  }

  static void showCancelError(
    BuildContext context,
    VoidCallback callback, {
    ErrorViewerOptions errorViewerOptions = const ErrVDialogOptions(),
  }) {
    // if (errorViewerOptions is ErrVSnackBarOptions) {
    //   // showErrorSnackBar(
    //   //   message:  AppStrings.timeoutError,
    //   //   context: context,
    //   //   callback: callback,
    //   //   errVSnackBarOptions: errorViewerOptions,
    //   // );
    // } else
      if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message: AppStrings.timeoutError,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message: AppStrings.timeoutError,
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }



  static void showInternalServerError(
    BuildContext context,
    VoidCallback callback, {
    ErrorViewerOptions errorViewerOptions = const ErrVDialogOptions(),
  }) {
    // if (errorViewerOptions is ErrVSnackBarOptions) {
    //   showErrorSnackBar(
    //     message: AppStrings.internalServerError,
    //     context: context,
    //     callback: callback,
    //     errVSnackBarOptions: errorViewerOptions,
    //   );
    // } else
      if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message:AppStrings.internalServerError,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message: AppStrings.internalServerError,
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }

  static void showFormatError(
    BuildContext context,
    VoidCallback callback, {
    ErrorViewerOptions errorViewerOptions = const ErrVDialogOptions(),
  }) {
    // if (errorViewerOptions is ErrVSnackBarOptions) {
    //   showErrorSnackBar(
    //     message:AppStrings.defaultError,
    //     context: context,
    //     callback: callback,
    //     errVSnackBarOptions: errorViewerOptions,
    //   );
    // } else
      if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message:AppStrings.defaultError,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message:AppStrings.defaultError,
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }

  static void showConnectionError(
    BuildContext context,
    VoidCallback callback, {
    ErrorViewerOptions errorViewerOptions = const ErrVDialogOptions(),
  }) {
    // if (errorViewerOptions is ErrVSnackBarOptions) {
    //   showErrorSnackBar(
    //     message: AppStrings.noInternetError,
    //     context: context,
    //     callback: callback,
    //     errVSnackBarOptions: errorViewerOptions,
    //   );
    // } else
      if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message: AppStrings.noInternetError,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message: AppStrings.noInternetError,
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }

  static void showCustomError(
    BuildContext context,
    String message, {
    ErrorViewerOptions errorViewerOptions = const ErrVSnackBarOptions(),
    VoidCallback? callback,
  }) {
    // if (errorViewerOptions is ErrVSnackBarOptions) {
    //   showErrorSnackBar(
    //     context: context,
    //     message: message,
    //     callback: callback,
    //     errVSnackBarOptions: errorViewerOptions,
    //   );
    // } else
      if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message: message,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message: message,
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }

  static void showUnexpectedError(
    BuildContext context, {
    ErrorViewerOptions errorViewerOptions = const ErrVSnackBarOptions(),
    VoidCallback? callback,
  }) {
    // if (errorViewerOptions is ErrVSnackBarOptions) {
    //   showErrorSnackBar(
    //     context: context,
    //     callback: callback,
    //     message:AppStrings.defaultError,
    //     errVSnackBarOptions: errorViewerOptions,
    //   );
    // } else
      if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message: AppStrings.defaultError,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message: AppStrings.defaultError,
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }

  static void showUnauthorizedError(
    BuildContext context, {
    ErrorViewerOptions errorViewerOptions = const ErrVSnackBarOptions(),
    VoidCallback? callback,
    required bool retryWhenNotAuthorized,
  }) {
    // if (errorViewerOptions is ErrVSnackBarOptions) {
    //   showErrorSnackBar(
    //     context: context,
    //     message: AppStrings.unauthorizedError ,
    //     callback: callback,
    //     errVSnackBarOptions: errorViewerOptions,
    //   );
    // } else
      if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message: AppStrings.unauthorizedError,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message: AppStrings.unauthorizedError,
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }

  static void showBadRequestError(
    BuildContext context,
    String? message, {
    ErrorViewerOptions errorViewerOptions = const ErrVSnackBarOptions(),
    VoidCallback? callback,
  }) {
    // if (errorViewerOptions is ErrVSnackBarOptions) {
    //   showErrorSnackBar(
    //     message: message ??AppStrings.badRequestError,
    //     context: context,
    //     callback: callback,
    //     errVSnackBarOptions: errorViewerOptions,
    //   );
    // } else
      if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message: message ??AppStrings.badRequestError,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message: message ?? AppStrings.badRequestError,
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }

  static void showForbiddenError(
    BuildContext context, {
    ErrorViewerOptions errorViewerOptions = const ErrVSnackBarOptions(),
    VoidCallback? callback,
    required bool retryWhenNotAuthorized,
  }) {
    // if (errorViewerOptions is ErrVSnackBarOptions) {
    //   showErrorSnackBar(
    //     context: context,
    //     message: AppStrings.forbiddenError,
    //     callback: callback,
    //     errVSnackBarOptions: errorViewerOptions,
    //   );
    // } else
      if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message: AppStrings.forbiddenError,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message: AppStrings.forbiddenError,
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }

  static void showNotFoundError(
    BuildContext context, {
    @required url,
    ErrorViewerOptions errorViewerOptions = const ErrVSnackBarOptions(),
    VoidCallback? callback,
  }) {
    // if (errorViewerOptions is ErrVSnackBarOptions) {
    //   showErrorSnackBar(
    //     context: context,
    //     message: AppStrings.notFoundError,
    //     callback: callback,
    //     errVSnackBarOptions: errorViewerOptions,
    //   );
    // } else
      if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message:AppStrings.notFoundError,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message: AppStrings.notFoundError,
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }

  static void showConflictError(
    BuildContext context, {
    ErrorViewerOptions errorViewerOptions = const ErrVSnackBarOptions(),
    VoidCallback? callback,
  }) {
    // if (errorViewerOptions is ErrVSnackBarOptions) {
    //   showErrorSnackBar(
    //     context: context,
    //     message: AppStrings.conflictError,
    //     callback: callback,
    //     errVSnackBarOptions: errorViewerOptions,
    //   );
    // } else
      if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message:AppStrings.conflictError,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message:AppStrings.conflictError,
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }

  static void showTimeoutError(
    BuildContext context, {
    ErrorViewerOptions errorViewerOptions = const ErrVSnackBarOptions(),
    VoidCallback? callback,
  }) {
    // if (errorViewerOptions is ErrVSnackBarOptions) {
    //   showErrorSnackBar(
    //     context: context,
    //     message: AppStrings.timeoutError,
    //     callback: callback,
    //     errVSnackBarOptions: errorViewerOptions,
    //   );
    // } else
      if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message: AppStrings.timeoutError,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message: AppStrings.timeoutError,
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }

  static void showUnknownError(
    BuildContext context, {
    ErrorViewerOptions errorViewerOptions = const ErrVSnackBarOptions(),
    VoidCallback? callback,
  }) {
    // if (errorViewerOptions is ErrVSnackBarOptions) {
    //   showErrorSnackBar(
    //     message: AppStrings.unknownError,
    //     callback: callback,
    //     context: context,
    //     errVSnackBarOptions: errorViewerOptions,
    //   );
    // } else
      if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message: AppStrings.unknownError,
        errVToastOptions: errorViewerOptions,
      );
    } else
      if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message: AppStrings.unknownError,
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }

  static void showSocketError(
    BuildContext context,
    VoidCallback callback, {
    ErrorViewerOptions errorViewerOptions = const ErrVSnackBarOptions(),
  }) {
    if (errorViewerOptions is ErrVSnackBarOptions ||
        errorViewerOptions is ErrVToastOptions ||
        errorViewerOptions is ErrVDialogOptions) {
      ErrVDialogOptions? errVDialogOptions = null;

      if (errorViewerOptions is ErrVDialogOptions) {
        errVDialogOptions = errorViewerOptions;
      }

      showCustomErrorDialog(
        context: context,
        message: AppStrings.noInternetError,
        callback: callback,
        errVDialogOptions: errVDialogOptions ?? const ErrVDialogOptions(),
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }
}
