import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peakmart/core/resources/assets_manager.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';

class UploadImageWidget extends StatefulWidget {
  const UploadImageWidget({super.key, required this.image});
  final Function(String pathOfImage) image;

  @override
  // ignore: library_private_types_in_public_api
  _UploadImageWidgetState createState() => _UploadImageWidgetState();
}

class _UploadImageWidgetState extends State<UploadImageWidget> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  widget.image(_image.toString());
    
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: double.infinity,
        height: 120.h,
        decoration: BoxDecoration(
          color: ColorManager.textFormBackground,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: ColorManager.textFormBorder),
        ),
        child: _image == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(IconsAssets.pickerIcon),
                  SizedBox(height: 10.h),
                  Text(AppStrings.addProductPhoto,
                      style: getMediumStyle(
                        color: ColorManager.grey1,
                        fontSize: FontSize.s14,
                      )),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(_image!,
                    fit: BoxFit.cover, width: double.infinity, height: 200),
              ),
      ),
    );
  }
}
