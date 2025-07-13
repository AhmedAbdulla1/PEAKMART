import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:Bid_Mart/core/error_ui/dialogs/custom_dialogs.dart';
import 'package:Bid_Mart/core/error_ui/error_viewer/dialog/errv_dialog_options.dart';
import 'package:Bid_Mart/core/resources/string_manager.dart';

void showCustomErrorDialog({
  required BuildContext context,
  String? message,
  VoidCallback? callback,
  required ErrVDialogOptions errVDialogOptions,
}) {
  if (Platform.isIOS ||
      errVDialogOptions.errVDialogType == ErrVDialogType.message) {
    showCustomMessageDialog(
      context: context,
      content: message ?? "",
      title:
          errVDialogOptions.title ?? 'oops',
      onButtonPressed: errVDialogOptions.confirmOptions?.onBtnPressed ??
          (a) {
            Navigator.pop(context);
            if (callback != null) callback();
          },
      buttonText: errVDialogOptions.confirmOptions?.buttonText ??
          AppStrings.retry,
    );
  }
  if (Platform.isAndroid) {
    // showCancelConfirmationDialog(
    //   context: context,
    //   content: message ?? "",
    //   title:
    //       errVDialogOptions.title ?? AppStrings.defaultError,
    //   onConfirm: errVDialogOptions.confirmOptions?.onBtnPressed ??
    //   // onCancel: (dContext) async => await SystemNavigator.pop(),
    //  , onCancel:,
    //   confirmText: errVDialogOptions.confirmOptions?.buttonText ??
    //       AppStrings.retry,
    //   cancelText: errVDialogOptions.cancelOptions?.buttonText ??
    //       'cancel',
    //   isDismissible: false,
    // );
  }
}
