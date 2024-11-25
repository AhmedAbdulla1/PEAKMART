import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/app/resources/theme_manager.dart';
import 'package:peakmart/features/main/main_view.dart';

class MyApp extends StatelessWidget {
  MyApp._internal();

  static MyApp instance = MyApp._internal();

  factory MyApp() => instance;

  // final AppPreferences _appPreferences = di.instance<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        title: 'Petmart',
        home: MainView(),
      ),
    );
  }
}
