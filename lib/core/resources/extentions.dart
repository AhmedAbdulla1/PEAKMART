import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension Gaps on num {
  Widget get hGap => SizedBox(width: toDouble().w);
  Widget get vGap => SizedBox(height: toDouble().h);
}

extension HandleCookies on List<Cookie> {

  Map<String, String> toMap() {
    print('to map');
    Map<String, String> map = {};
    for (Cookie cookie in this) {
      map[cookie.name] = cookie.value;
    }
    print('map $map');
    return map;
  }
}