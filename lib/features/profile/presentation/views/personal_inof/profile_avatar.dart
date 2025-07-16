import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/values_manager.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final String? tempImagePath;
  final VoidCallback onEditTap;

  const ProfileAvatar({
    super.key,
    required this.imageUrl,
    required this.tempImagePath,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;

    if (tempImagePath != null) {
      imageProvider = FileImage(File(tempImagePath!));
    } else {
      imageProvider = CachedNetworkImageProvider(imageUrl);
    }

    return Stack(
      children: [
        CircleAvatar(
          radius: AppSize.s55.r + AppSize.s1_5.r,
          child: CircleAvatar(
            radius: AppSize.s55.r,
            backgroundColor: Colors.purple.withValues(alpha:0.2),
            backgroundImage: imageProvider,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            radius: AppSize.s15.r + AppSize.s1_5.r,
            backgroundColor: Colors.white,
            child: GestureDetector(
              onTap: onEditTap,
              child: CircleAvatar(
                radius: 15.r,
                backgroundColor: const Color(0xffF2F4F7),
                child: Icon(
                  Icons.mode_edit_outline_outlined,
                  size: 20.r,
                  color: ColorManager.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
