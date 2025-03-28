import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart' as di;
import 'package:peakmart/core/resources/routes_manager.dart';
import 'package:peakmart/core/resources/theme/app_theming_cubit/app_theme_cubit.dart';
import 'package:peakmart/core/resources/theme/dark_theme_data.dart';
import 'package:peakmart/core/resources/theme/light_theme_data.dart';

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
      builder: (context, child) => BlocProvider(
        create: (context) => AppThemeCubit(),
        child: BlocBuilder<AppThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            print('themeMode: $themeMode');
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              themeMode: themeMode,

              theme: getLightTheme(),
              darkTheme: getDarkTheme(),
              title: 'Peakmart',
              initialRoute: Routes.root,
              onGenerateRoute: RouteGenerator.getRoute,
            );
          },
        ),
      ),
    );
  }
}
