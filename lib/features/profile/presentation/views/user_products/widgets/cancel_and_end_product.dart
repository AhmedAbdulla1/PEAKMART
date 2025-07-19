import 'dart:developer';

import 'package:Bid_Mart/core/error_ui/dialogs/custom_dialogs.dart';
import 'package:Bid_Mart/core/error_ui/error_viewer/error_viewer.dart'
    show ErrorViewer;
import 'package:Bid_Mart/core/error_ui/error_viewer/toast/errv_toast_options.dart';
import 'package:Bid_Mart/core/error_ui/toast.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/extentions.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:Bid_Mart/features/profile/presentation/state_m/user_products/user_products_cubit.dart';
import 'package:Bid_Mart/features/profile/presentation/state_m/user_products/user_products_states.dart';
import 'package:Bid_Mart/features/profile/presentation/views/personal_inof/passwrod_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancelAndEndButtonsWidget extends StatelessWidget {
  const CancelAndEndButtonsWidget({super.key, required this.productId});
  final int productId;

  Future<void> _handleAction({
    required BuildContext context,
    required String status,
    required IconData icon,
    required String title,
    required String content,
    required Color confirmTextColor,
    required Color confirmButtonColor,
  }) async {
    showCancelConfirmationDialog(
      context: context,
      icon: icon,
      title: title,
      content: content,
      onConfirm: () async {
        Navigator.pop(context);
        final userPassword = await showPasswordDialog(context);
        if (!context.mounted) return;
        if (userPassword == null || userPassword.isEmpty) {
          Toast.show("Please enter your password to proceed.");
          return;
        }

        status == "ended"
            ? context.read<UserProductsCubit>().endProduct(
                  productId: productId,
                  password: userPassword,
                )
            : status == "canceled"
                ? context.read<UserProductsCubit>().cancelProduct(
                      productId: productId,
                      password: userPassword,
                    )
                : null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProductsCubit, UserProductsStates>(
      listener: (context, state) {
        if (state is CancelUserProductSuccess) {
          context.read<UserProductsCubit>().getUploadedProducts();

          Toast.show("Product canceled successfully",
              backgroundColor: ColorManager.green);

          log(" cancel success");
        } else if (state is EndUserProductSuccess) {
          context.read<UserProductsCubit>().getUploadedProducts();

          Toast.show("Product ended successfully",
              backgroundColor: ColorManager.green);

          log(" end success");
        } else if (state is CancelUserProductFailed) {
          ErrorViewer.showError(
              errorViewerOptions: const ErrVToastOptions(
                  backGroundColor: ColorManager.textFormErrorBorder,
                  textColor: ColorManager.white),
              context: context,
              error: state.error,
              callback: () {});
        }
      },
      builder: (context, state) {
        final isLoading = state is CancelUserProductLoading;
        return SizedBox(
          width: double.infinity,
          height: 60.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AbsorbPointer(
                absorbing: isLoading,
                child: Row(
                  children: [
                    /// End Button
                    Expanded(
                      child: SizedBox(
                        height: 40.h,
                        child: ElevatedButton(
                          onPressed: () => _handleAction(
                            context: context,
                            status: "ended",
                            icon: Icons.help_outline,
                            title: 'End Auction?',
                            content:
                                'Are you sure you want to end this auction?',
                            confirmTextColor: Colors.white,
                            confirmButtonColor: ColorManager.primary,
                          ),
                          child: Text(
                            'End',
                            style: getBoldStyle(
                              fontSize: FontSize.s16,
                              color: ColorManager.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    8.hGap,

                    /// Cancel Button
                    Expanded(
                      child: SizedBox(
                        height: 40.h,
                        child: OutlinedButton(
                          onPressed: () => _handleAction(
                            context: context,
                            status: "canceled",
                            icon: Icons.info_outline_rounded,
                            title: 'Are you sure you want to cancel?',
                            content:
                                'If you cancel, 25% of the amount you paid will be deducted.',
                            confirmTextColor: Colors.white,
                            confirmButtonColor: ColorManager.primary,
                          ),
                          child: Text(
                            'Cancel',
                            style: getBoldStyle(
                              fontSize: FontSize.s16,
                              color: context.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        );
      },
    );
  }
}
