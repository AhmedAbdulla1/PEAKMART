import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/extentions.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/string_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/core/resources/theme/extentaions/app_theme_ext.dart';

import 'show_dialog.dart';

void showCustomMessageDialog({
  String? title,
  String? content,
  String? buttonText,
  Function(BuildContext context)? onButtonPressed,
  required BuildContext context,
}) {
  ShowDialog().showElasticDialog(
    context: context,
    builder: (BuildContext myContext) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(title ?? '', style: getBoldStyle(fontSize: 22)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  content ?? '',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              if (buttonText != null)
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: onButtonPressed == null
                      ? () {
                          // Navigator.of(myContext).pop();
                          // Nav.pop(myContext);
                        }
                      : () {
                          onButtonPressed(myContext);
                        },
                  textColor: Theme.of(myContext).primaryColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(42),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}

void showCustomDialogWithIconDialog({
  Widget? icon,
  Color? iconBackColor,
  String? content,
  String? buttonText,
  bool? isDesmissible,
  bool? isBackPopped,
  Function(BuildContext context)? onButtonPressed,
  required BuildContext context,
}) {
  ShowDialog().showElasticDialog(
    barrierDismissible: isDesmissible ?? true,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          return isBackPopped ?? true;
        },
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: iconBackColor ?? Colors.greenAccent,
                        borderRadius: BorderRadius.circular(200)),
                    child: Center(
                      child: icon ??
                          const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(content ?? '', style: getBoldStyle(fontSize: 22)),
                ),
                if (buttonText != null)
                  MaterialButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: onButtonPressed == null
                        ? () {
                            // Navigator.of(context).pop();
                            Navigator.pop(context);
                          }
                        : () => onButtonPressed(context),
                    textColor: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: Text(
                        buttonText,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(42),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showCancelConfirmationDialog({
  required BuildContext context,
  IconData? icon,
  String? title,
  String? content,
  void Function()? onConfirm,
  void Function()? onCancel,
  bool? isDismissible,
  bool? canPop,
  String? cancelText,
  String? confirmText,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: ColorManager.primary,
            size: 60,
          ),
          16.vGap,
          Text(
            title ?? '',
            textAlign: TextAlign.center,
            style: getBoldStyle(
                fontSize: title!.length > 20 ? FontSize.s16 : FontSize.s22),
          ),
          12.vGap,
          Text(
            content ?? '',
            textAlign: TextAlign.center,
            style: getRegularStyle(
                fontSize: FontSize.s16,
                color: context.isDarkMode
                    ? ColorManager.greyColor
                    : ColorManager.darkGrey),
          ),
          24.vGap,
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                  ),
                  child: const Text('Continue'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

showCustomDialogWithTextField(
    {required BuildContext context,
    String? labelText,
    String? hintText,
    int? minLines,
    int? maxLines,
    double? height,
    String title = '',
    Function(String text)? onConfirm,
    FormFieldValidator<String>? validator,
    TextInputAction? textInputAction,
    Color? helperTextColor,
    TextInputType? keyboardType}) {
  final textKey = GlobalKey<FormFieldState<String>>();
  final textController = TextEditingController();
  showDialog(
      context: context,
      builder: (BuildContext bc) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.all(
              Radius.circular(40),
            ),
          ),
          //scrollable: true,
          child: SizedBox(
            width: ScreenUtil().screenWidth,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  //  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: ScreenUtil().setSp(40),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          labelText ?? "",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: ScreenUtil().setSp(32),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(35),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            // Nav.pop(context);
                          },
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            child: Text(
                              AppStrings.cancel,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(42),
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                        MaterialButton(
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          onPressed: () {
                            if (textKey.currentState!.validate()) {
                              if (onConfirm != null) {
                                onConfirm(textController.text);
                              }
                              Navigator.of(context).pop();
                              // Nav.pop(context);
                            }
                          },
                          textColor: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            child: Text(
                              AppStrings.confirm,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(42),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
