import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:provider/provider.dart';

import '../../features/bid_owner/presentation/state_mang/add_product_cubit/image_picker_controller.dart';

class AddProductImagePicker extends StatelessWidget {
  final String title;
  final Function(File? image)? onSingleImageSelected;
  final Function(List<File?> images)? onMultipleImageSelected;
  const AddProductImagePicker(
      {super.key,
      required this.title,
      this.onSingleImageSelected,
      this.onMultipleImageSelected});

  void _showImageSourceBottomSheet(BuildContext context) {
    final controller =
        Provider.of<ImagePickerController>(context, listen: false);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  controller.pickSingleImage();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  controller.pickMultipleImages();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ImagePickerController>(
      builder: (context, controller, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _showImageSourceBottomSheet(context),
              child: Container(
                width: double.infinity,
                height: 150.h,
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? ColorManager.darkGrey.withOpacity(.2)
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                      color: context.isDarkMode
                          ? ColorManager.grey1
                          : ColorManager.textFormBorder),
                ),
                child: controller.images.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/picker_icon.svg'),
                          SizedBox(height: 10.h),
                          Text(
                            title,
                            style: TextStyle(
                                color: ColorManager.textFormHint,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image.file(
                          controller.images.first,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
              ),
            ),
            if (controller.images.length > 1)
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: SizedBox(
                  height: 80.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.images.length - 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.file(
                            controller.images[index + 1],
                            fit: BoxFit.cover,
                            width: 80.w,
                            height: 80.h,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
