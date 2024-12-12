import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/resources/routes_manager.dart';
import 'package:peakmart/app/resources/theme_manager.dart';
import 'package:peakmart/features/auth/presentation/views/login/login_view.dart';
import 'package:peakmart/app/di.dart' as di;

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static MyApp instance = const MyApp._internal();

  factory MyApp() => instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = di.instance<AppPreferences>();

  @override
  void didChangeDependencies() {
    _appPreferences.getLocale().then((value) {
      print(value);
      context.setLocale(value);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        theme: getApplicationTheme(),
        title: 'Petmart',
        initialRoute: LogInView.routeName,
        onGenerateRoute: RouteGenerator.getRoute,
      ),
    );
  }
}
