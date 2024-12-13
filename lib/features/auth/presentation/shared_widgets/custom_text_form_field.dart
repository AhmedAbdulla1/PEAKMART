import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.iconData,
      this.onChanged});
  final String labelText;
  final String hintText;
  final IconData iconData;
  final Function(String)? onChanged;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

bool isPressed = false;

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      validator: (value) {
        if ((value == null || value.isEmpty)) {
          return 'This field is required.';
        }
        return null;
      },
      decoration: InputDecoration(
          // contentPadding: const EdgeInsets.all(22),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: const BorderSide(color: Color(0xffA8A8A9)),
          // ),
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: const BorderSide(color: Color(0xffA8A8A9)),
          // ),
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: const BorderSide(color: Color(0xffA8A8A9)),
          // ),
          labelText: widget.labelText,
          // labelStyle:
          //     getMediumStyle(fontSize: FontSize.s14, color: ColorManager.black)
          //         .copyWith(fontFamily: FontConstants.fontMontserratFamily),
          // hintStyle: getMediumStyle(
          //         fontSize: FontSize.s12, color: ColorManager.lightGrey)
          //     .copyWith(fontFamily: FontConstants.fontMontserratFamily),
          // hintText: widget.hintText,
          prefixIconColor: ColorManager.lightGrey,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Icon(
              widget.iconData,
              size: 28.sp,
            ),
          ),
          suffixIcon: widget.hintText == 'Password'
              ? Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    icon: isPressed
                        ? const Icon(
                            Icons.remove_red_eye_outlined,
                          )
                        : const Icon(
                            Icons.remove_red_eye_outlined,
                          ),
                    onPressed: () {
                      setState(() {
                        isPressed = !isPressed;
                      });
                    },
                    iconSize: 28.sp,
                  ),
                )
              : const SizedBox(
                  width: 2,
                  height: 2,
                ),
          suffixIconColor: ColorManager.lightGrey),
    );
  }
}
